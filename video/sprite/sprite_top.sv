`define SCRN_ROW_MAX 9'd288

`define SCRN_COL_MAX 10'd224

module sprite_top
    (input  logic clk, rst,
     
     //input  logic [7:0] sw,
     
     //VGA inputs
     //Valid rows are between 0 and 288
     //valid cols are between 0 and 224
     input  logic [8:0] row,
     input  logic [9:0] col,
     input  logic       blank,
      
     // new signals for the collision fix
     output logic         cpu_pause, 
     output logic [15:0]  ram_addr, 
     output logic [7:0]   ram_din, 
     output logic         pill_eaten, 
     input logic [7:0]    tile_ROM_addr,

     //RAM control 
     input logic [7:0] sprite_RAM_din,
     input logic       wr_en,
     input logic [15:0] RAM_addr,
    
     //color outputs
     output logic [3:0] sprite_r, sprite_g, sprite_b);     

     //Determine if in range
     //Output 0 addrs if out of range
     logic row_ok, col_ok;
     logic in_range;

     assign row_ok = (0 <= row) && (row<`SCRN_ROW_MAX);
     assign col_ok = (0 <= col) && (col<`SCRN_COL_MAX);

     assign in_range = row_ok && col_ok;

     //Get colors
     logic [3:0] calc_r, calc_g, calc_b;

     sprite_datapath spr_dat(.clk,
                             .rst,

                             .cpu_pause,
                             .ram_addr, 
                             .ram_din, 
                             .pill_eaten, 
                             .tile_ROM_addr,

                             .wr_en,
                             .sprite_RAM_din,
                             .RAM_addr,

                              //VGA connections
                             .row,
                             .col,

                             //Colors
                             .sprite_r(calc_r),
                             .sprite_g(calc_g),
                             .sprite_b(calc_b));

      //Now assign actual color outputs

      assign sprite_r = (blank||~in_range)?4'h0:calc_r;
      assign sprite_g = (blank||~in_range)?4'h0:calc_g;
      assign sprite_b = (blank||~in_range)?4'h0:calc_b;


endmodule: sprite_top
