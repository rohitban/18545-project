

module comparator
  #(parameter WIDTH = 6)
  (input [WIDTH-1:0] A,B,
   output AltB, AeqB, AgtB);

  assign AltB = A < B;
  assign AeqB = A == B;
  assign AgtB = A >B;

endmodule: comparator

module adder
  #(parameter WIDTH = 1)
  (output logic [WIDTH-1:0] Sum,
   output logic       Cout,
    input logic [WIDTH-1:0] A,B,
    input logic       Cin);

  assign {Cout,Sum} = A + B + Cin;


endmodule: adder

module mux
  #(parameter WIDTH = 2)
  (output logic      Y,
   input logic [WIDTH-1:0] I,
   input logic [$clog2(WIDTH)-1:0] Sel);

  assign Y = I[Sel];

endmodule: mux

/*
module mux_test;
  logic [3:0] I;
  logic [1:0] Sel;
  logic Y;

  mux #(4) m1(.*);

  initial begin
  $monitor($time, " I=%b, Sel=%d, Y=%b",I,Sel,Y);
  I=4'b0110;
  Sel = 2'd0;
  #10;
  Sel = 2'd1;
  #10;
  Sel = 2'd2;
  #10;
  Sel = 2'd3;
  #10 $finish;
  end


endmodule: mux_test
*/  

module mux2to1
  #(parameter WIDTH = 1)
  (output logic [WIDTH-1:0] Y,
   input logic [WIDTH-1:0] I0,I1,
   input logic Sel);

  assign Y = Sel?I1:I0;

endmodule: mux2to1

/*
module mux2to1_test;
  logic [1:0] Y,I0,I1;
  logic Sel;

  mux2to1 #(2) m1(.*);

  initial begin
  $monitor($time, " I0=%d,I1=%d,Y=%d,Sel=%b",I0,I1,Y,Sel);
  I0 = 2'd3;
  I1 = 2'd0;
  Sel = 1'b0;
  #10;
  Sel =1'b1;
  #10 $finish;
  end

endmodule: mux2to1_test
*/

module mux4to1
  #(parameter WIDTH = 1)
  (output logic [WIDTH-1:0] Y,
   input logic [WIDTH-1:0] I0,I1,I2,I3,
   input logic [1:0] Sel);

  always_comb
    case (Sel)
      2'b00: Y = I0;
      2'b01: Y = I1;
      2'b10: Y = I2;
      2'b11: Y = I3;
    endcase

endmodule: mux4to1

/*
module mux4to1_test;
  logic [2:0] Y,I0,I1,I2,I3;
  logic [1:0] Sel;

  mux4to1 #(3) m1(.*);

  initial begin
  $monitor($time, " I0=%d,I1=%d,I2=%d,I3=%d,Y=%d,Sel=%b",
                    I0,I1,I2,I3,Y,Sel);
  I0 = 3'd3;
  I1 = -3'd1 + 3'd2;
  I2 = 3'd5;
  I3 = 3'd7;
  Sel = 2'd0;
  #10;
  Sel = 2'd1;
  #10;
  Sel = 2'd2;
  #10;
  Sel = 2'd3;
  #10  $finish;
  end

endmodule: mux4to1_test
*/


module decoder
  #(parameter WIDTH = 3)
  (input  logic [WIDTH-1:0] I,
   input  logic             en,
   output logic [(2**WIDTH)-1:0] D);
  
  always_comb begin
  D = 0;
  if (en==1'b1)
    D[I] = 1'b1;
  end

endmodule: decoder

/*
module decoder_test;
  logic [1:0] I;
  logic       en;
  logic [3:0] D;

  decoder #(2) d1(.*);

  initial begin 
  $monitor($time, " I=%d, D=%b, en=%b",I,D,en);
  en=1'b1;
  I=2'd0;
  #10;
  I=2'd1;
  #10;
  I=2'd2;
  #10;
  I=2'd3;
  #10;
  en =0;
  #10;
  I=2'd0;
  #10 $finish;
  end

endmodule: decoder_test
*/

module register
  #(parameter WIDTH = 3)
  (input logic [WIDTH-1:0] D,
   input logic             en,clr,
   input logic             clk,reset,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clk,posedge reset)
    if (reset)
      Q <= 0;
    else if (clr)
      Q <= 0;
    else if (en)
      Q <= D;

endmodule: register

module sync_register
  #(parameter WIDTH = 3)
  (input logic [WIDTH-1:0] D,
   input logic             en,clr,
   input logic             clk,
   output logic [WIDTH-1:0] Q);

  always_ff @(posedge clk)
    if (clr)
      Q <= 9'd194;
    else if (en)
      Q <= D;

endmodule: sync_register



/*
module register_test;
  logic [2:0] D,Q;
  logic       en, clk, clr, reset;

  register #(3) r1(.*);
  
  initial begin
  $monitor($time, " Q=%d,D=%d,en=%b,clr=%b",
                    Q,D,en,clr);
  reset = 1;
  reset <= #2 0;
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
  #5;
  D <= 3'd5;
  en <= 1;
  @(posedge clk)
  #1;

  en <= 0;
  clr <= 1;
  @(posedge clk);
  #1;

  clr <= 0;
  en <= 1;
  D <= 3'd7;
  @(posedge clk);
  #1;

  en <= 0;
  D <= 3'd1;
  @(posedge clk);
  #1;
  @(posedge clk);
  @(posedge clk);
  $finish;
  end

endmodule: register_test
*/


/** A SIPO shift register with 1 bit input s_in
    it shifts the output Q left when both en and left are asserted
    and right if both en and ~left are asserted(left has priority 
    over ~left)
**/
module shift_register
 #(parameter w = 3)
  (output logic [w-1:0] Q,
   input  logic         clk,en,left,
   input  logic         s_in);

  always_ff @(posedge clk)
    if (en)
      begin
      if (left)
        Q <= (Q << 1) | s_in;
      else
        Q <= (Q >> 1) | (s_in << w-1);
      end

endmodule: shift_register

/*
module shift_register_test;
  logic [2:0] Q;
  logic clk,en,left,s_in;
 
  shift_register #(3) s1(.*);

  initial begin
  $monitor($time," Q = %b, en=%b,left=%b,s_in=%b",Q,en,left,s_in);
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
  en <= 1;
  left <= 1;
  s_in <= 1;
  @(posedge clk);
  #1;

  s_in <= 0;
  @(posedge clk);
  #1;
  
  s_in <= 1;
  @(posedge clk);
  #1;

  en <= 0;
  s_in <= 0;
  @(posedge clk);
  #1;

  @(posedge clk);
  left <= 0;
  en <= 1;
  @(posedge clk);
  #1;
  @(posedge clk);
  @(posedge clk);
  s_in <= 1;
  @(posedge clk);
  #1;
  left <= 1;
  @(posedge clk);
  @(posedge clk);
  #1;
  $finish;
  end

endmodule: shift_register_test
*/

module counter
 #(parameter w = 4)
  (input  logic clk, up,
   input  logic en,clr,load,
   input  logic [w-1:0] D,
   output logic [w-1:0] Q);

  always_ff @(posedge clk)
    if (clr)
      Q <= 0;
    else if (load)
      Q <= D;
    else if (en)
      begin
        if (up)
          Q <= Q + 1;
        else
          Q <= Q - 1;
      end

endmodule: counter

module limit_counter
 #(parameter w = 4)
  (input  logic clk,
   input  logic en,clr,
   input  logic [w-1:0] limit,
   output logic [w-1:0] Q);

  always_ff @(posedge clk)
    if (clr)
      Q <= 0;
    else if (en)
      begin
      if (Q == limit)
        Q <= 0;
      else
        Q <= Q + 1;
      end

endmodule: limit_counter

/*
module limit_counter_test;
  logic clk,en,clr;
  logic [3:0] limit,Q;

  limit_counter #(4) c1(.*);

  initial begin
  $monitor($time, " Q=%d,limit=%d,en=%b,clr=%b",
                    Q,limit,en,clr);
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
    clr <= 1;
    @(posedge clk);
    @(posedge clk);
   
    clr <= 0;
    @(posedge clk);

    limit  <= 3'd5;
    @(posedge clk);
    #1;

    en <= 1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;

    @(posedge clk);
    $finish;
  end
  
endmodule: limit_counter_test
*/

module BCD_1DIGIT_counter
  (input  logic clk,
   input  logic en,clr,
   output logic [3:0] Q,
   output logic       digit_inc);

  assign digit_inc = (Q == 4'd9) && en ;
 
  always_ff @(posedge clk)
    if (clr)
      Q <= 0;
    else if (en)
      begin
      if (Q == 4'd9)
        Q <= 0;
      else
        Q <= Q + 4'd1;
      end

endmodule: BCD_1DIGIT_counter

/**
module BCD_1digit_test;
  logic clk, en, clr, digit_inc;
  logic [3:0] Q;

  BCD_1DIGIT_counter bcd1(.*);

  initial begin
  $monitor($time," Q=%d,en=%b,clr=%b,digit_inc=%b",Q,en,clr,digit_inc);
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
  clr <= 1;
  @(posedge clk);
  clr <= 0;
  @(posedge clk);
  en <= 1;
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  en <= 0;
  clr <= 1;
  @(posedge clk);
  clr <= 0;
  @(posedge clk);
  en <= 1;
  for (int i = 0; i <= 9; i++)
    @(posedge clk);
  
  @(posedge clk);
  @(posedge clk);
  #10;
  $finish;
  end

endmodule: BCD_1digit_test
**/

module BCD_counter
  (input  logic clk,
   input  logic en,clr,
   output logic [3:0] high,low);
  
  logic digit_inc;
  
  BCD_1DIGIT_counter l(.Q(low),.*);
  BCD_1DIGIT_counter h(.Q(high),.digit_inc( ),.en(digit_inc),.*);

endmodule: BCD_counter

/**
module BCD_counter_test;
  logic clk, en, clr;
  logic [3:0] high,low;

  BCD_counter bcd1(.*);

  initial begin
  $monitor($time," high=%d,low=%d,en=%b,clr=%b",high,low,en,clr);
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
  clr <= 1;
  @(posedge clk);
  clr <= 0;
  @(posedge clk);
  en <= 1;
  for(int i = 0; i <= 36; i++)
    @(posedge clk);
  
  @(posedge clk);
  @(posedge clk);
  #10;
  $finish;
  end

endmodule: BCD_counter_test
**/

/*
module counter_test;
  logic clk,up,en,clr,load;
  logic [2:0] D,Q;

  counter #(3) c1(.*);

  initial begin
  $monitor($time, " Q=%d,D=%d,en=%b,up=%b,load=%b,clr=%b",
                    Q,D,en,up,load,clr);
  clk = 0;
  forever #10 clk = ~clk;
  end

  initial begin
    clr <= 1;
    @(posedge clk);
    @(posedge clk);
   
    clr <= 0;
    @(posedge clk);

    D  <= 3'd2;
    load <= 1'b1;
    @(posedge clk);
    #1;

    load <= 0'b0;
    @(posedge clk);

    en <= 1;
    up <= 1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    
    up <= 0;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;
    @(posedge clk);
    #1;

    @(posedge clk);
    $finish;
  end
  
endmodule: counter_test

*/

module range_check
 #(parameter w = 4)
 (input  logic [w-1:0] val,high,low,
  output logic       in_between);
  
  assign in_between = (low <= val) && (val <= high);

endmodule: range_check

/*
module test_range_check;
  logic [10:0] val,low,high;
  logic in_between;

  range_check #(11) r1(.*);

  initial begin
  $monitor($time," high=%d,low=%d,val=%d,in_between=%b",
                   high,low,val,in_between);
  low = 11'd288;
  high = 11'd1568;
  val = 11'd288;
  #10;
  val = 11'd300;//In between
  #10 val = 11'd287;//Less than low
  #10 val = 11'd288;//Equal to low
  #10 val = 11'd1569;//Greater than high
  #10 val = 11'd1568;//Equal to high
  #10 $finish;
  end
endmodule: test_range_check
*/

module offset_check
 #(parameter w = 4)
 (input  logic [w-1:0] val,low,delta,
  output logic       in_between);

  logic [w-1:0] high;
  assign high = low + delta;
 
  range_check #(w) r1(.*);

endmodule: offset_check 

/*
module test_offset_check;
  logic [3:0] val,low,delta;
  logic in_between;

  offset_check #(4) r1(.*);

  initial begin
  $monitor($time," delta=%d,low=%d,val=%d,in_between=%b",
                   delta,low,val,in_between);
  low = 4'd5;
  delta = 4'd3;
  val = 4'd6;//in between
  #10;
  val = 4'd5;//equal to low
  #10 val = 4'd1;//less than low
  #10 val = 4'd4;//less than low
  #10 val = 4'd8;//equal to low+delta
  #10 val = 4'd9;//greater than low+delta
  #10 $finish;
  end
endmodule: test_offset_check
*/
