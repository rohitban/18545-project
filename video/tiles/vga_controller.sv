`include "lib.sv"

`define TOTAL_ROWS 9'd480
`define TOTAL_COLS 10'd640

//50MHz timings
/*
`define HS_LIM 11'd1599
`define VS_LIM 10'd520

`define VS_LOW 10'd32
`define HS_LOW 11'd192

`define HS_DISP_LOW 11'd287
`define HS_DELTA 11'd1279

`define VS_DISP_LOW 10'd32
`define VS_DELTA 10'd479
*/

//100MHz timings

`define HS_LIM 12'd3199
`define VS_LIM 10'd521

`define VS_LOW 10'd2
`define HS_LOW 12'd384

`define HS_DISP_LOW 12'd576
`define HS_DISP_HI 12'd3136

`define VS_DISP_LOW 10'd31
`define VS_DISP_HI 10'd511

//`define HS_LIM 12'd1599
//`define VS_LIM 10'd521

//`define VS_LOW 10'd2
//`define HS_LOW 12'd192

//`define HS_DISP_LOW 12'd288
//`define HS_DISP_HI 12'd1568

//`define VS_DISP_LOW 10'd31
//`define VS_DISP_HI 10'd511

module vga_ctrl
  (input  logic clk, reset,
   output logic HS, VS, blank,vblank,hblank,
   //output logic [11:0] hs_count,
   //output logic [9:0] vs_count,
   output logic [8:0] row,
   output logic [9:0] col);

  logic [11:0] hs_count;
  logic hs_disp,vs_inc,vs_disp;
  logic [9:0] vs_count;
  logic col_inc, row_inc;

  limit_counter #(12) hscount(.clk(clk),.en(1'b1),.clr(reset),
                              .limit(`HS_LIM),.Q(hs_count));

  comparator #(12) hscmp(.A(hs_count),.B(`HS_LIM),.AeqB(vs_inc),
                         .AgtB( ),.AltB( ));

  limit_counter #(10) vscount(.clk(clk),.en(vs_inc),.clr(reset),
                              .limit(`VS_LIM),.Q(vs_count));

  assign hs_disp = `HS_DISP_LOW <= hs_count && hs_count < `HS_DISP_HI; 


  assign vs_disp = `VS_DISP_LOW <= vs_count && vs_count < `VS_DISP_HI;

  assign blank = ~(hs_disp && vs_disp);
  
  assign vblank = ~vs_disp;

  assign hblank = ~hs_disp;
  
  assign HS = `HS_LOW <= hs_count && hs_count < `HS_LIM;
  assign VS = `VS_LOW <= vs_count && vs_count < `VS_LIM;

  assign col_inc = ((hs_count[1:0] & 2'b11)==2'b11)?hs_disp:1'b0;

  limit_counter #(10) colcount(.clk(clk),.en(col_inc),.clr(reset),
                               .limit(`TOTAL_COLS-10'd1),.Q(col));

  assign row_inc = (vs_disp && vs_inc);

  limit_counter #(9) rowcount(.clk(clk),.en(row_inc),.clr(reset),
                               .limit(`TOTAL_ROWS-9'd1),.Q(row));


endmodule: vga_ctrl









/*
module red
  (input  logic [9:0] col,
   output logic [7:0] VGA_R);

  logic is_red;

  range_check #(10) r(.val(col),.low(10'd320),.high(10'd639),
                      .in_between(is_red));

  assign VGA_R = (is_red)?8'hFF:8'h00;

endmodule: red 

module green
  (input  logic [9:0] col,
   output logic [7:0] VGA_G);

  logic g1,g2;

  range_check #(10) gc1(.val(col),.low(10'd160),.high(10'd319),
                      .in_between(g1));

  range_check #(10) gc2(.val(col),.low(10'd480),.high(10'd639),
                      .in_between(g2));

  assign VGA_G = (g1||g2)?8'hFF:8'h00;

endmodule: green

module blue
  (input  logic [9:0] col,
   output logic [7:0] VGA_B);

  logic b1,b2,b3,b4;

  range_check #(10) bc1(.val(col),.low(10'd80),.high(10'd159),
                      .in_between(b1));

  range_check #(10) bc2(.val(col),.low(10'd240),.high(10'd319),
                      .in_between(b2));

  range_check #(10) bc3(.val(col),.low(10'd400),.high(10'd479),
                      .in_between(b3));

  range_check #(10) bc4(.val(col),.low(10'd560),.high(10'd639),
                      .in_between(b4));

  assign VGA_B = (b1||b2||b3||b4)?8'hFF:8'h00;

endmodule: blue
   
*/
									  
