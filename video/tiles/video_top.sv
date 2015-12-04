
//FRAME boundaries
`define COL_MIN 10'd208
`define COL_MAX 10'd432

`define ROW_MIN 9'd96
`define ROW_MAX 9'd384



module video_top
    (input  logic       clk, rst,
     
     //input  logic [7:0] sw,//TEST
     
     //ACCESS tiles
     input  logic [7:0] tile_ROM_addr,
     output logic [15:0] tile_RAM_addr,

     //ACCESS PALETTES
     input  logic [5:0] palette_ROM_addr,
     output logic [15:0] palette_RAM_addr,
     
     
     //SPRITE INPUTS
     input  logic [7:0] sprite_RAM_din,
     input  logic       wr_en,
     input  logic [15:0] RAM_addr,

     output logic [3:0] vgaRed, vgaGreen, vgaBlue,
     output logic       Hsync, Vsync);

    //TEST
//    logic [7:0] tile_ROM_addr;
//    logic [15:0] tile_RAM_addr;
    
//    logic [5:0] palette_ROM_addr;
//    logic [15:0] palette_RAM_addr;
    
//    logic rst;
    
//    assign rst = btnC;
    ////////////
    logic [9:0] col;
    logic [8:0] row;
    logic       blank;
    logic       hblank, vblank;
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
    
    /*
    assign vgaRed = 4'h0;
    assign vgaGreen = ('d10 <= row && row < 'd400)?4'hF:0;
    assign vgaBlue = 4'h0;
    */
    /////////////////////////////////////////

    /*
    clk_400MHz clk_div(.clk_in1(clk),
                       .clk_out1(clk_400));
    */

    vga_ctrl v1(.clk,
                .reset(rst),
                .HS(Hsync),
                .VS(Vsync),
                .row,
                .col,
                .hblank,
                .vblank,
                .blank);

    /*
    red_blue rb(.row,
                .col,
                .VGA_R(vgaRed),
                .VGA_B(vgaBlue),
                .VGA_G(vgaGreen));
    */
    
   
    //TILES
    logic [3:0] tile_r,tile_g,tile_b;
        
    tile_block tb(.clk,//(clk_400),
                 .rst(rst),

                 //Get ROM addrs as inputs
                 .tile_ROM_addr,
                 .palette_ROM_addr,

                 //Output RAM addrs
                 .tile_RAM_addr,
                 .palette_RAM_addr,

                 .row(off_row),
                 .col(off_col),

                 .blank,

                 .red(tile_r),
                 .blue(tile_b),
                 .green(tile_g));
   
                 
                 
                 
   //SPRITES
   logic [3:0] sprite_r, sprite_g, sprite_b;
   
   sprite_top sprt(.clk,
                   .rst,
                   
                   //.sw,//sw[7:0] for testing
                   
                   .row(off_row),
                   .col(off_col),
                   
                   .blank,
                   
                   //ram control
                   .sprite_RAM_din,
                   .wr_en,
                   .RAM_addr,
                   
                   //Colors
                   .sprite_r,
                   .sprite_g,
                   .sprite_b);
                   
                   
   sprite_tile_overlay ovrly(.tile_r,
                             .tile_g,
                             .tile_b,
                             
                             .sprite_r,
                             .sprite_g,
                             .sprite_b,
                             
                             .red,
                             .green,
                             .blue);       
                   
    
    
    /*
    color_band clr(.col,
                   .VGA_R(vgaRed),
                   .VGA_R(vgaRed),
                   .VGA_B(vgaBlue),
                   .VGA_G(vgaGreen));
    */              
endmodule: video_top

module sprite_tile_overlay
    (input  logic [3:0] sprite_r, sprite_g, sprite_b,
     input  logic [3:0] tile_r, tile_g, tile_b,
     output logic [3:0] red, green, blue);
     
     logic sred_0, sblue_0, sgreen_0;
     
     logic black_sprite;
     
     
     assign sred_0 = sprite_r=='d0;
     assign sblue_0 = sprite_b=='d0;
     assign sgreen_0 = sprite_g=='d0;
     
     assign black_sprite = sred_0&&sblue_0&&sgreen_0;
     
     assign red = (black_sprite)?tile_r:sprite_r;
     assign green = (black_sprite)?tile_g:sprite_g;
     assign blue = (black_sprite)?tile_b:sprite_b;
     
endmodule: sprite_tile_overlay

module adjustVGA
    (input  logic [9:0] col,
    input  logic [8:0] row,
    input  logic [3:0] r, g, b,
    output logic [3:0] vgaRed,vgaBlue,vgaGreen);

    logic valid_row;
    logic valid_col;
    
    assign valid_col = (0 <= col && col < 'd639);
    
    assign valid_row = (0 <= col && col < 'd470);
    
    assign vgaRed = (valid_row&&valid_col)?r:4'h0;
    assign vgaGreen = (valid_row&&valid_col)?g:4'h0;
    assign vgaBlue = (valid_row&&valid_col)?b:4'h0;
    
endmodule: adjustVGA

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



