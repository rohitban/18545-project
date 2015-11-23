`include "vga_controller.sv"

module top
    (input  logic       clk, btnC,
     output logic [3:0] vgaRed, vgaGreen, vgaBlue,
     output logic       Hsync, Vsync);

    logic [9:0] col;
    logic [8:0] row;
    logic       blank;


    vga_ctrl v1(.clk,
                .reset(btnC),
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
    
    dr_demo demo(.col,
                 .row,
                 .red(vgaRed),
                 .green(vgaGreen),
                 .blue(vgaBlue));
    
    /*
    color_band clr(.col,
                   .VGA_R(vgaRed),
                   .VGA_B(vgaBlue),
                   .VGA_G(vgaGreen));
     */              
endmodule: top

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



