`define NUM_SPRITES 8



module pos_reg
    (input  logic       clk, rst,save_pos,
     input  logic [7:0] x_pos, y_pos,
     output logic [7:0] x_pos_old, y_pos_old);

    always_ff@(posedge clk, posedge rst)
        if(rst) begin
          x_pos_old <= 0;
          y_pos_old <= 0;
        end
        else if(save_pos)
          x_pos_old <= x_pos;
          y_pos_old <= y_pos;
        end

endmodule: pos_reg

module sprite_reg
    (input  logic clk, rst,
     input  logic [7:0] din,

     //For saving signal state
     input  logic [7:0] x_pos_old, y_pos_old,
     input  logic       restore_old,

     input  logic       ld_x,ld_y,ld_num_flip,ld_palette,
     output logic [7:0] x,y,
     output logic [7:0] palette_index,
     output logic [5:0] sprite_num,
     output logic       xflip,yflip);

    logic [7:0] num_flip;

    assign xflip = num_flip[1];
    assign yflip = num_flip[0];

    assign sprite_num = num_flip[7:2];
    
    always_ff@(posedge clk ,posedge rst) begin
        if(rst) begin
            x <= 0;
            y <= 0;
            num_flip <= 0;
            palette_index <= 0;
        end
        else if(ld_x)
          x <= din;
        else if(ld_y)
          y <= din;
        else if(ld_num_flip)
          num_flip <= din;
        else if(ld_palette)
          palette_index <= din;
        else if(restore_old) begin
          x <= x_pos_old;
          y <= y_pos_old;
        end
    end

endmodule: sprite_reg


//remap to screen coordinates
module row_col_remap
    (input  logic [7:0] row,
     input  logic [7:0] col,
     output logic [7:0] adj_row,
     output logic [7:0] adj_col);


    assign adj_col = 8'd224 - row +  8'd16 ;//exclude top and bottom 2 rows
    

    assign adj_row = 8'd255 - col + 8'd16;

endmodule: row_col_remap


module has_sprite
    (input  logic [7:0] sprite_x,
     input  logic [7:0] sprite_y,
     input  logic [8:0] curr_row, 
     input  logic [7:0] adj_col,
     output logic       has_sprite);

    logic [7:0] adj_row;
    
    logic row_ok, col_ok;
    
    assign adj_row = curr_row[7:0];
    
    assign col_ok = sprite_x <= adj_col && adj_col < sprite_x + 'd16;

    assign row_ok = sprite_y <= adj_row && adj_row < sprite_y + 'd16;
    
    
    
    assign has_sprite = row_ok && col_ok;

endmodule: has_sprite


module sprite_mem_remap
    (input  logic [15:0] RAM_addr,
     input  logic        wr_en,
     output logic        ld_flip_bit,

     //To deal with the collision FSM
     output logic [2:0] update_index,
     output logic       sprite_update,

     output logic [`NUM_SPRITES-1:0] ld_x, ld_y,
     output logic [`NUM_SPRITES-1:0] ld_num_flip,ld_palette);

    always_comb begin
        ld_x = 0;
        ld_y = 0;
        ld_num_flip = 0;
        ld_palette = 0;
        ld_flip_bit = 0;
        sprite_update = 0;
        update_index = 0;
        if(wr_en) begin
          case(RAM_addr)

            //LOAD FLIP BIT
            16'h5003: ld_flip_bit = 1'b1;
            //LOAD X
            16'h5060: begin
                ld_x[0] = 1'b1;
                sprite_update = 1;
            end
            16'h5062: begin
                ld_x[1] = 1'b1;
                sprite_update = 1;
                update_index = 1;
            end
            16'h5064: begin
                ld_x[2] = 1'b1;
                sprite_update = 1;
                update_index = 'd2;
            end
            16'h5066: begin
                ld_x[3] = 1'b1;
                sprite_update = 1;
                update_index = 'd3;
            end

            16'h5068: begin
                ld_x[4] = 1'b1;
                sprite_update = 1;
                update_index = 'd4;
            end
            16'h506a: begin
                ld_x[5] = 1'b1;
                sprite_update = 1;
                update_index= 'd5;
            end
            16'h506c: begin
                ld_x[6] = 1'b1;
                sprite_update = 1;
                update_index = 'd6;
            end
            16'h506e: begin
                ld_x[7] = 1'b1;
                sprite_update = 1;
                update_index= 'd7;
            end

            //LOAD Y
            16'h5061: begin
                ld_y[0] = 1'b1;
                sprite_update = 1;
            end
            16'h5063: begin
                ld_y[1] = 1'b1;
                sprite_update = 1;
                update_index = 'd1;
            end
            16'h5065: begin
                ld_y[2] = 1'b1;
                sprite_update = 1;
                update_index = 'd2;
            end

            16'h5067: begin
                ld_y[3] = 1'b1;
                sprite_update = 1;
                update_index = 'd3;
             end
            16'h5069: begin
                ld_y[4] = 1'b1;
                sprite_update = 1;
                update_index = 'd4;
            end
            16'h506b: begin
                ld_y[5] = 1'b1;
                sprite_update = 1;
                update_index = 'd5;
            end
            16'h506d: begin
                ld_y[6] = 1'b1;
                sprite_update = 1;
                update_index= 'd6;
            end
            16'h506f: begin
                ld_y[7] = 1'b1;
                sprite_update = 1;
                update_index = 'd7;
            end
            
            //LOAD num and flip
            16'h4ff0: ld_num_flip[0] = 1'b1;
            16'h4ff2: ld_num_flip[1] = 1'b1;
            16'h4ff4: ld_num_flip[2] = 1'b1;
            16'h4ff6: ld_num_flip[3] = 1'b1;
            16'h4ff8: ld_num_flip[4] = 1'b1;
            16'h4ffa: ld_num_flip[5] = 1'b1;
            16'h4ffc: ld_num_flip[6] = 1'b1;
            16'h4ffe: ld_num_flip[7] = 1'b1;

            //LOAD palette:
            16'h4ff1: ld_palette[0] = 1'b1;
            16'h4ff3: ld_palette[1] = 1'b1;
            16'h4ff5: ld_palette[2] = 1'b1;
            16'h4ff7: ld_palette[3] = 1'b1;
            16'h4ff9: ld_palette[4] = 1'b1;
            16'h4ffb: ld_palette[5] = 1'b1;
            16'h4ffd: ld_palette[6] = 1'b1;
            16'h4fff: ld_palette[7] = 1'b1;
          endcase
        end
    end

endmodule: sprite_mem_remap

module sprite_datapath
    (input  logic   clk, rst,
     input  logic [8:0] row,
     input  logic [9:0] col,

     // new signals for the collision fix
     output logic         cpu_pause, 
     output logic [15:0]  ram_addr, 
     output logic [7:0]   ram_din, 
     output logic         pill_eaten, 
     input logic [7:0]    tile_ROM_addr,
     
     //Read from RAM
     input  logic [7:0] sprite_RAM_din,
     input  logic       wr_en,
     input logic [15:0] RAM_addr,
     
     //Output the colors that the sprite will have
     //at that position(if any)
     output logic [3:0] sprite_r, sprite_g, sprite_b);
   
    //Deal with flip bit

    logic [7:0] flip_bit;
    logic       ld_flip_bit;

    always_ff@(posedge clk, posedge rst)
        if(rst)
          flip_bit <= 0;
        else if(ld_flip_bit)
          flip_bit <= sprite_RAM_din; 

    /////////////////
    //STORE SPRITES//
    /////////////////
    
    logic [7:0] fsm_dout;
    logic [31:0] fsm_palette_out;
   
    logic sprite_update;
    logic [2:0] update_index;

    //Register control signals
    logic [`NUM_SPRITES-1:0] ld_x, ld_y;
    logic [`NUM_SPRITES-1:0] ld_num_flip;
    logic [`NUM_SPRITES-1:0] ld_palette;
    
    //MAP LOAD SIGNALS:       //RAM inputs
    sprite_mem_remap spr_remap(.RAM_addr,
                              .wr_en,
                                
                              .ld_flip_bit,

                              //Sprite collision
                              .sprite_update,
                              .update_index,
                                
                               //Load sigs
                              .ld_x,
                              .ld_y,
                              .ld_num_flip,
                              .ld_palette);

    //Sprite outputs
    logic [`NUM_SPRITES-1:0][7:0] sprite_x;
    logic [`NUM_SPRITES-1:0][7:0] sprite_y;

    logic [`NUM_SPRITES-1:0][7:0] palette_index;

    logic [`NUM_SPRITES-1:0][5:0] sprite_num;

    logic [`NUM_SPRITES-1:0] xflip, yflip;
    
    //Old sprite outputs

    logic [`NUM_SPRITES-1:0][7:0] old_sprite_x;
    logic [`NUM_SPRITES-1:0][7:0] old_sprite_y;

    logic [`NUM_SPRITES-1:0]      save_pos;

    logic [`NUM_SPRITES-1:0]      restore;

    //remapped rows and cols(match coordinate system)
    logic [`NUM_SPRITES-1:0][7:0] adj_row, adj_col;

    //HAS_SPRITE signal
    logic [`NUM_SPRITES-1:0] has_sprite;

    //Create the registers to hold the sprite data
    generate
    genvar i;

    for(i=0; i<`NUM_SPRITES;i++) begin
      
      //STORE OLD POSITION DATA

      pos_reg old(.clk,
                  .rst,
                  .x_pos(sprite_x[i]),
                  .y_pos(sprite_y[i]),
                  
                  .x_pos_old(old_sprite_x[i]),
                  .y_pos_old(old_sprite_y[i]),

                  .save_pos(save_pos[i]));

      //STORE INFO 
      sprite_reg sreg(.clk, .rst,
                      .din(sprite_RAM_din),

                      //LOAD sigs
                      .ld_x(ld_x[i]),
                      .ld_y(ld_y[i]),
                      .ld_num_flip(ld_num_flip[i]),
                      .ld_palette(ld_palette[i]),

                      //OLD INPUTS
                      .x_pos_old(old_sprite_x[i]),
                      .y_pos_old(old_sprite_y[i]),
                      .restore_old(restore[i]),


                      //Outputs 
                      .x(sprite_x[i]),
                      .y(sprite_y[i]),

                      .palette_index(palette_index[i]),
                      .sprite_num(sprite_num[i]),
                      .xflip(xflip[i]),
                      .yflip(yflip[i]));

      
      //REMAP coordinates
      row_col_remap rmp(.row(sprite_x[i]),
                        .col(sprite_y[i]),
                        .adj_row(adj_row[i]),
                        .adj_col(adj_col[i]));//transform 
                        //pacman coordinates to top left based 
                        //screen coordinates
      //assign adj_row[i] = 'd32;
      
      //assign adj_col[i] = i*'d16;
      //check if a sprite occurs at the given screen coordinates
      //CHECK for occurence
      has_sprite hs(.curr_row(row[8:0]),
                    .adj_col(col[7:0]),

                    .sprite_x(adj_col[i]),
                    .sprite_y(adj_row[i]),

                    .has_sprite(has_sprite[i]));
                            
    end
    endgenerate

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
    
    logic [7:0] active_palette_addr;

    logic [5:0] active_num;

    logic active_xflip, active_yflip;

    assign active_num = sprite_num[active_sprite];
    
    //assign active_num = sw[7:2];

    assign active_xflip = xflip[active_sprite];
    
    //assign active_xflip = sw[0];

    assign active_yflip = yflip[active_sprite];

    //assign active_yflip = sw[1];

    assign active_palette_addr = palette_index[active_sprite];

     
    //assign active_palette_addr = 'd3;

    //now get relative row and col number
    logic [7:0] row_disp, col_disp;

    assign row_disp = row[7:0] - adj_row[active_sprite];

    assign col_disp = col[7:0] - adj_col[active_sprite];

    //get the pixel number

    logic [7:0] pixel_num;

    logic xflip_adj, yflip_adj;

    assign xflip_adj = (flip_bit==0)?active_xflip:~active_xflip;

    assign yflip_adj = (flip_bit==0)?active_yflip:~active_yflip;

    sprite_pixel_num spr_pix(.row(row_disp[3:0]),
                             .col(col_disp[3:0]),
                             .xflip(xflip_adj),
                             .yflip(yflip_adj),
                             .pixel_num);
    
    logic [11:0] pix_addr;

    //use this to look up sprite ROM
    assign pix_addr = {active_num,pixel_num[7:2]};


    //SPRITE ROM
    logic [7:0] pixel_out;
    //assign pixel_out = 0;
    
    sprite_rom spr_rom(.clka(clk),
                       .addra(pix_addr),
                       .douta(pixel_out));
    
    ///////////////////////


    logic [1:0] pixel_data;

    pixel_data_dcd data_dcd(.pixel_offset(pixel_num[1:0]),
                            .pixel_byte(pixel_out),
                            .pixel_data);

    logic [1:0] active_data;
    
    //Validate screen position
    logic row_valid, col_valid, pos_valid;
    
    assign row_valid = (9'd16 <= row) && (row < 9'd272);
    
    assign col_valid  = (10'd0 <= col)&& (col<10'd224);
    
    assign pos_valid = row_valid&&col_valid;

    assign active_data = (none_active||~pos_valid)?2'b00:pixel_data;
        


    //palette rom
    //use active_palette_addr to access palette rom

    //assign active_palette = 0;
    
    palette_4byte_rom spr_palette(.clka(clk),
                                  .addra(active_palette_addr[5:0]),
                                  .douta(active_palette));

    //select color
    logic [7:0] palette_data;

    logic [7:0] color_byte;

    spr_palette_mux ps_mux(.palette(active_palette),
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

module spr_palette_mux
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
     
     
endmodule: spr_palette_mux

