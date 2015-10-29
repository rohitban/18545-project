module full_tile
    (input  logic       clk,rst,
     input  logic [4:0] sel_pal,
     input  logic [8:0] row,
     input  logic [9:0] col,
     output logic [3:0] red,blue,green);

    logic [5:0] tile_row;
    logic [4:0] tile_col;

    logic row_ok;
    logic col_ok;
    logic dc;
    
    assign tile_row = row[8:3];
    assign tile_col = col[7:3];

    assign row_ok = 0 <= row && row < 9'd128;
    assign col_ok = 0 <= col && col < 10'd128;

    assign dc = !(row_ok & col_ok);
    //if dc, display black

    //Assign tiles to screen locations
    //16x16 grid

    logic [7:0] tilemap_addr;

    //tile_addr = col + 16*row
    assign tilemap_addr = {3'b0,tile_col} + {tile_row[3:0],4'b0};
    

    //TODO: access the ROM and get the tile index from there
    //Tilemap ROM, will change to RAM later
    logic [7:0] tile_index;
    
    //assign tile_index = tilemap_addr;
     
    tilemap_rom tm_rom(.clka(clk),
                       .addra(tilemap_addr),
                       .douta(tile_index));
                       
    

    //Now determine the pixel number

    logic [5:0] pixel_num;

    pixel_num num(.row_offset(row[2:0]),
                  .col_offset(col[2:0]),
                  .pixel_num);

    //Now determine the address of the pixel

    logic [11:0] pix_addr;

    //each byte contains 4 pixels
    assign pix_addr = {tile_index,4'b0} + pixel_num[5:2];

    
    //TODO: add tile rom here
    logic [7:0] tile_byte;// accessed from tile rom
    
    tile_rom t_rom(.addra(pix_addr),
                   .clka(clk),
                   .douta(tile_byte));
    
    logic [1:0] pixel_data;

    pixel_data_dcd pix_dat(.pixel_offset(pixel_num[1:0]),
                           .pixel_byte(tile_byte),
                           .pixel_data);

    //palette ROM here
    logic [7:0] color_index;
    logic [31:0] palette;
    logic [5:0] palette_index;
    
    assign palette_index = {1'b0,sel_pal};
    
    //Large palette ROM
    
    palette_4byte_rom p4_rom(.clka(clk),
                             .addra(palette_index),
                             .douta(palette));
    
    palette_mux pmux(.palette,
                     .pixel_data,
                     .palette_data(color_index));    
    
    
    //Access colors
    logic [3:0] color_index_small;
    logic [7:0] color_byte;
    
    assign color_index_small = color_index[3:0];
    
    color_store c_store(.color_index(color_index_small),
                        .rst,
                        .clk,
                        .color_byte);
                        
    //now decompose coloring
    logic [2:0] red_frac, green_frac;
    logic [1:0] blue_frac;
    
    assign blue_frac = color_byte[7:6];
    assign green_frac = color_byte[5:3];
    assign red_frac = color_byte[2:0];
    
    logic [3:0] red_val,blue_val,green_val;
    
    assign red_val = {red_frac[3],red_frac};
    assign green_val = {green_frac[3],green_frac};
    assign blue_val = {1'b0,blue_frac[1],blue_frac};
                     
    //assign colors
    assign red = (dc)?4'h0:red_val;
    assign green = (dc)?4'h0:green_val;
    assign blue = (dc)?4'h0:blue_val;
    //assign red = (dc)?4'h0:(pixel_data!=2'b0)?4'hF:4'h0;
    //assign green = 0;
    //assign blue = 0;
    
    

endmodule: full_tile

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
