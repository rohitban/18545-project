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

    red_blue rb(.row,
                .col,
                .VGA_R(vgaRed),
                .VGA_B(vgaBlue),
                .VGA_G(vgaGreen));

endmodule: top

module red_blue
  (input  logic [9:0] col,
   input  logic [8:0] row,
   output logic [3:0] VGA_R,VGA_B,VGA_G);
	
	logic left, right, top, bottom;
	
	assign left = 10'd0 <= col < 10'd320;
	
	assign right = 10'd320 <= col < 10'd640;
	
	assign top = 9'd0 <= row < 9'd240;
	
	assign bottom = 9'd240 <= row < 9'd480;
	
	//assign VGA_R = (top&&left || bottom&&right)?4'hF:4'h0;
	//assign VGA_B = (top&&right || bottom&&left)?4'hF:4'h0;
	assign VGA_R = 4'hF;
	assign VGA_B = 4'h0;
	assign VGA_G = 4'h0;
	
endmodule: red_blue



