`define NUM_SPRITES 8


typedef struct packed{
  logic [31:0] palette;
  logic [7:0] x_pos;
  logic [7:0] y_pos;
  logic [5:0] sprite_num;
  logic      xflip;
  logic      yflip;
} sprite_data;



//Registers to hold sprite data
module sprite_data_reg
    #(parameter i = 0)
    (input  logic [7:0]  data_in,
     input  logic [31:0] palette_in,
     input  logic        clk, rst,
     input  logic        ld_x,ld_y,
     input  logic        ld_num_flips,ld_palette,
     output sprite_data  d_out);

    always_ff@(posedge clk, posedge rst) begin
        if(rst)
          d_out <= 0;
        else if(ld_x)
          d_out.x_pos <= data_in;
        else if(ld_y)
          d_out.y_pos <= data_in;
        else if(ld_num_flips) begin
          d_out.sprite_num <= data_in[7:2];
          d_out.xflip <= data_in[1];
          d_out.yflip <= data_in[0];
        end
        if(ld_palette)
          d_out.palette <= palette_in;
    end

    
endmodule: sprite_data_reg


//remap to screen coordinates
module row_col_remap
    (input  logic [7:0] row,
     input  logic [7:0] col,
     output logic [7:0] adj_row,
     output logic [7:0] adj_col);


    assign adj_row = 8'd255 - row - 8'd1;//exclude top and bottom 2 rows

    assign adj_col = 8'd224 - col - 8'd1;

endmodule: row_col_remap


module has_sprite
    (input  logic [7:0] sprite_x,
     input  logic [7:0] sprite_y,
     input  logic [7:0] adj_row, adj_col,
     output logic       has_sprite);

    logic row_ok, col_ok;

    assign col_ok = sprite_x <= adj_col && adj_col < sprite_x + 'd16;

    assign row_ok = sprite_y <= adj_row && adj_row < sprite_y + 'd16;
    
    assign has_sprite = row_ok && col_ok;

endmodule: has_sprite


module sprite_datapath
    (input  logic   clk, rst,vblank,
     input  logic [8:0] row,
     input  logic [9:0] col,

     //Read from RAM
     input  logic [7:0] sprite_RAM_din,
     output logic       rd_en,
     output logic [15:0]sprite_dp_RAM_addr,
     
     //Output the colors that the sprite will have
     //at that position(if any)
     output logic [3:0] sprite_r, sprite_g, sprite_b);
    
    /////////////////
    //STORE SPRITES//
    /////////////////
    
    logic [7:0] fsm_dout;
    logic [31:0] fsm_palette_out;
    
    //Register control signals
    logic [`NUM_SPRITES-1:0] ld_x, ld_y;
    logic [`NUM_SPRITES-1:0] ld_num_flips;
    logic [`NUM_SPRITES-1:0] ld_palette;
    
    sprite_data [`NUM_SPRITES-1:0] sprite_info;


    //remapped rows and cols(match coordinate system)
    logic [`NUM_SPRITES-1:0][7:0] adj_row, adj_col;

    //HAS_SPRITE signal
    logic [`NUM_SPRITES-1:0] has_sprite;

    //Create the registers to hold the sprite data
    generate
    genvar i;

    for(i=0; i<`NUM_SPRITES;i++) begin
      sprite_data_reg #(i) sprites(.clk,.rst,
                                   .ld_x(ld_x[i]),
                                   .ld_y(ld_y[i]),
                                   .ld_num_flips(ld_num_flips[i]),
                                   .ld_palette(ld_palette[i]),
                            
                                   //Data to load
                                   .data_in(fsm_dout),
                                   .palette_in(fsm_palette_out),

                                   .d_out(sprite_info[i]));

      
      row_col_remap rmp(.row(sprite_info[i].x_pos),
                        .col(sprite_info[i].y_pos),
                        .adj_row(adj_row[i]),
                        .adj_col(adj_col[i]));//transform 
                        //pacman coordinates to top left based 
                        //screen coordinates

      //check if a sprite occurs at the given screen coordinates
      has_sprite hs(.adj_row(row[7:0]),
                    .adj_col(col[7:0]),

                    .sprite_x(adj_col[i]),
                    .sprite_y(adj_row[i]),

                    .has_sprite(has_sprite[i]));
                            
    end
    endgenerate

    sprite_fsm fsm(.clk,.rst,
                   .vblank,

                   //Read from RAM
                   .sprite_RAM_din,
                   .rd_en,
                   .sprite_RAM_addr(sprite_dp_RAM_addr),

                   //output data
                   .fsm_dout,
                   .palette_out(fsm_palette_out),

                   //control regs
                   .ld_x,
                   .ld_y,
                   .ld_num_flips,
                   .ld_palette);
    /////////////////////////////////////////



    /////////////////////////
    //CHOOSE ACTIVE SPRITE//
    ////////////////////////
    logic [2:0] active_sprite;
    logic       none_active;

    always_comb begin
        none_active = 0;
        casex(has_sprite)
            8'b????_???1: active_sprite = 'd0;
            8'b????_??10: active_sprite = 'd1;
            8'b????_?100: active_sprite = 'd2;
            8'b????_1000: active_sprite = 'd3;
            8'b???1_0000: active_sprite = 'd4;
            8'b??10_0000: active_sprite = 'd5;
            8'b?100_0000: active_sprite = 'd6;
            8'b1000_0000: active_sprite = 'd7;
            8'b0000_0000: begin
                active_sprite = 'd0;
                none_active = 1;
            end
        endcase
    end
    ////////////////////////////
    
    /////////////////////////////////////////
    //ACCESS DATA DURING ROW AND COL STROBE//
    /////////////////////////////////////////

    //now get values for the active sprite
    logic [31:0] active_palette;
    
    logic [5:0] sprite_num;

    logic xflip, yflip;

    assign sprite_num = sprite_info[active_sprite].sprite_num;

    assign xflip = sprite_info[active_sprite].xflip;

    assign yflip = sprite_info[active_sprite].yflip;

    assign active_palette = sprite_info[active_sprite].palette;


    //now get relative row and col number
    logic [7:0] row_disp, col_disp;

    assign row_disp = row[7:0] - sprite_info[active_sprite].y_pos;

    assign col_disp = col[7:0] - sprite_info[active_sprite].x_pos;

    //get the pixel number

    logic [7:0] pixel_num;
    
    sprite_pixel_num spr_pix(.row(row_disp[3:0]),
                             .col(col_disp[3:0]),
                             .xflip,
                             .yflip,
                             .pixel_num);
    
    logic [11:0] pix_addr;

    //use this to look up sprite ROM
    assign pix_addr = {sprite_num,pixel_num[7:2]};


    //TODO: add sprite ROM
    
    logic [7:0] pixel_out;
    assign pixel_out = 'd0;
    ///////////////////////


    logic [1:0] pixel_data;

    pixel_data_dcd data_dcd(.pixel_offset(pixel_num[1:0]),
                            .pixel_byte(pixel_out),
                            .pixel_data);

    logic [1:0] active_data;


    assign active_data = (none_active)?2'b00:pixel_data;


    //select color
    logic [7:0] palette_data;

    logic [7:0] color_byte;

    palette_mux ps_mux(.palette(active_palette),
                       .pixel_data(active_data),
                       .palette_data);

    color_store cs_store(.color_index(palette_data[3:0]),
                         .rst,
                         .clk,
                         .color_byte);
    
    //split colors
    logic [2:0] r,g,b;

    assign b = color_byte[7:6];
    assign g = color_byte[5:3];
    assign r = color_byte[2:0];

    assign sprite_r = {r[2],r};

    assign sprite_g = {g[2],g};

    assign sprite_b = {1'b0,b[1],b};
    //////////////////////////////////////////////

endmodule: sprite_datapath

module palette_mux
    (input logic [31:0] palette,
     input logic [1:0] pixel_data,
     output logic [7:0] palette_data);
     
     logic [3:0][7:0] palette_bytes;
     
     always_comb begin
        palette_bytes[3] = palette[7:0];
        palette_bytes[2] = palette[15:8];
        palette_bytes[1] = palette[23:16];
        palette_bytes[0] = palette[31:24];
     end
     
     assign palette_data = palette_bytes[pixel_data];
     
     
endmodule: palette_mux

