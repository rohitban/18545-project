`define TILE_MEM_OFFSET 16'h4000
`define PALETTE_MEM_OFFSET 16'h4400


`include "color_store.sv"
`include "pixel_num.sv"
`include "pixel_data.sv"
`include "tilemap_addr.sv"

module tile_block
    (input  logic       clk,rst,

     //Palette and tile ROM addresses
     input  logic [7:0] tile_ROM_addr,
     input  logic [5:0] palette_ROM_addr,

     input  logic [8:0] row,
     input  logic [9:0] col,
     input  logic       blank,

     //Broad Cast RAM addresses
     output logic [15:0] tile_RAM_addr,
     output logic [15:0] palette_RAM_addr,

     output logic [3:0] red,blue,green);

    
    //Access RAM
    logic [15:0] raw_addr;
    
    tilemap_addr_dcd addr(.row,
                          .col,
                          .raw_addr);
    
    logic [15:0] tile_RAM_raw, palette_RAM_raw;

    assign tile_RAM_raw = `TILE_MEM_OFFSET + raw_addr;
    
    assign palette_RAM_raw = `PALETTE_MEM_OFFSET + raw_addr;
    
    assign tile_RAM_addr = (blank)?16'h0:tile_RAM_raw;
    assign palette_RAM_addr = (blank)?16'h0:palette_RAM_raw;

    //Now determine the pixel number

    logic [5:0] pixel_num;

    pixel_num num(.row_offset(row[2:0]),
                  .col_offset(col[2:0]),
                  .pixel_num);

    //Now determine the address of the pixel

    logic [11:0] pix_addr;

    //each byte contains 4 pixels
    assign pix_addr = {tile_ROM_addr,4'b0} + pixel_num[5:2];

    
    //TILE ROM
    logic [7:0] tile_byte;// accessed from tile rom
   
   
    /*
    tile_rom t_rom(.addra(pix_addr),
                   .clka(clk),
                   .douta(tile_byte));
    */
    assign tile_byte = 0;//TODO: make rom output
    

    logic [1:0] pixel_data;

    pixel_data_dcd pix_dat(.pixel_offset(pixel_num[1:0]),
                           .pixel_byte(tile_byte),
                           .pixel_data);

    //palette ROM here
    logic [7:0] color_index;
    logic [31:0] palette;
    logic [5:0] palette_index;
    
    assign palette_index = palette_ROM_addr;
    
    //Large palette ROM
    
    /*
    palette_4byte_rom p4_rom(.clka(clk),
                             .addra(palette_index),
                             .douta(palette));
    */

    assign palette = 1;//TODO: make rom output

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

    
    //Assign colors
    assign red = {red_frac[2],red_frac};
    assign green = {green_frac[2],green_frac};
    assign blue = {1'b0,blue_frac[1],blue_frac};
    
    

endmodule: tile_block

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
