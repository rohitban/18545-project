`include "vga_controller.sv"

module top
    (input  logic       clk, btnC,
     output logic [3:0] vgaRed, vgaGreen, vgaBlue,
     output logic       Hsync, Vsync);

    logic [9:0] col;
    logic [8:0] row;


    vga_ctrl v1(.clk,
                .reset(btnC),
                .HS(Hsync),
                .VS(Vsync),
                .row,
                .col);

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
	
	logic l,r,t,b;
	
	range_check #(10) left(.val(col),.low(10'd0),.high(10'd319),
	                          .in_between(l));
	
	range_check #(9) top(.val(row),.low(9'd0),.high(9'd239),
	                          .in_between(t));
	
	range_check #(10) right(.val(col),.low(10'd320),.high(10'd639),
	                          .in_between(r));
	
	range_check #(9) bottom(.val(row),.low(9'd240),.high(9'd479),
	                          .in_between(b));
	
	
	assign VGA_R = (t&&l || b&&r)?4'hF:4'h0;
	assign VGA_B = (t&&r || b&&l)?4'hF:4'h0;
	assign VGA_G = 8'h00;
	
endmodule: red_blue



