

module BCDtoSevenSegment
  (input logic [3:0] bcd,
  output logic [6:0] segment);

  always_comb begin
    case (bcd)
      4'd0: segment = 7'b100_0000;
      4'd1: segment = 7'b111_1001;
      4'd2: segment = 7'b010_0100;
      4'd3: segment = 7'b011_0000;
      4'd4: segment = 7'b001_1001;
      4'd5: segment = 7'b001_0010;
      4'd6: segment = 7'b000_0010;
      4'd7: segment = 7'b111_1000;
      4'd8: segment = 7'b000_0000;
      4'd9: segment = 7'b001_1000;
      4'd10 : segment = 7'b0001000; 
      4'd11 : segment = 7'b0000011;
      4'd12 : segment = 7'b1000110; 
      4'd13 : segment = 7'b0100001; 
      4'd14 : segment = 7'b0000110; 
      4'd15 : segment = 7'b0001110;
      default: segment = 7'b111_1111;
   endcase
  end

endmodule: BCDtoSevenSegment

/*
module bcd_test;
  logic [3:0] bcd;
  logic [6:0] segment;

  BCDtoSevenSegment bcd2ss(.*);

  initial begin
  $monitor($time," bcd=%d, segment= %b",bcd, segment);
  for (bcd=4'd0;bcd<4'd9;bcd++)
    #10;
  #10 $finish;
  end

endmodule: bcd_test 
*/
