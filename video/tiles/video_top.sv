
//FRAME boundaries
`define COL_MIN 10'd208
`define COL_MAX 10'd432

`define ROW_MIN 9'd96
`define ROW_MAX 9'd384

`include "vga_controller.sv"
`include "tile_top.sv"


module video_top
    (input  logic       clk, rst,
     
     //ACCESS tiles
     input  logic [7:0] tile_ROM_addr,
     output logic [15:0] tile_RAM_addr,

     //ACCESS PALETTES
     input  logic [5:0] palette_ROM_addr,
     output logic [15:0] palette_RAM_addr,

     output logic [3:0] vgaRed, vgaGreen, vgaBlue,
     output logic       Hsync, Vsync);

    logic [9:0] col;
    logic [8:0] row;
    logic       blank;
    //logic       clk_400;

    
    logic [3:0] red,green,blue;
    logic [8:0] off_row;
    logic [9:0] off_col;

    logic row_ok;
    logic col_ok;

    //DRAW FRAME
    assign off_row = row-`ROW_MIN;
    assign off_col = col-`COL_MIN;

    assign row_ok = `ROW_MIN <= row && row < `ROW_MAX;
    assign col_ok = `COL_MIN <= col && col < `COL_MAX;

    assign vgaRed = (row_ok&col_ok)?red:4'hF;
    assign vgaGreen = (row_ok&col_ok)?green:4'hF;
    assign vgaBlue = (row_ok&col_ok)?blue:4'hF;
    /////////////////////////////////////////

    /*
    clk_wiz_0 clk_div(.clk_in1(clk),
                     .reset(rst),
                     .clk_out1(clk_400),
                     .locked( ));
    */

    vga_ctrl v1(.clk,
                .reset(rst),
                .HS(Hsync),
                .VS(Vsync),
                .row,
                .col,
                .blank);

    /*
    red_blue rb(.row,
                .col,
                .VGA_R(vgaRed),
                .VGA_B(vgaBlue),
                .VGA_G(vgaGreen));
    */
    
    
    tile_block tb(.clk,//(clk_400),
                 .rst(rst),

                 //Get ROM addrs as inputs
                 .tile_ROM_addr,
                 .palette_ROM_addr,

                 //Output RAM addrs
                 .tile_RAM_addr,
                 .palette_RAM_addr,

                 .row,
                 .col,

                 .red,
                 .blue,
                 .green);
    
    
    /*
    color_band clr(.col,
                   .VGA_R(vgaRed),
                   .VGA_B(vgaBlue),
                   .VGA_G(vgaGreen));
    */              
endmodule: video_top

module red_blue
  (input  logic [9:0] col,
   input  logic [8:0] row,
   output logic [3:0] VGA_R,VGA_B,VGA_G);
	
	logic l,r,t,b;
	
	assign l = 0 <= col && col < 10'd320;
	
	assign t = 0 <= row && row < 9'd240;
	
	assign r = 10'd320 <= col && col < 10'd640;
	
	assign b = 9'd240 <= row && row < 9'd480;
	
	assign VGA_R = (t&&l || b&&r)?4'hF:4'h0;
	assign VGA_B = (t&&r || b&&l)?4'hF:4'h0;
	assign VGA_G = 8'h00;
	
endmodule: red_blue

module color_band
    (input  logic [9:0] col,
     output logic [3:0] VGA_R,VGA_G, VGA_B);
     
     always_comb begin
        VGA_R = 0;
        VGA_B = 0;
        VGA_G = 0;
        
        if(10'd0 <= col && col < 10'd160)
            VGA_R = 4'hF;
        else if(10'd160 <= col && col < 10'd320)
            VGA_G = 4'hF;
        else if(10'd320 <= col && col < 10'd480)
            VGA_B = 4'hF;
            
     end
endmodule: color_band



