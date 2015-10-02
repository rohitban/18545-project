

module vga_test;
  logic CLOCK_50, reset, HS,VS,blank;
  logic [9:0] col;
  logic [8:0] row;
  //logic [11:0] hs_count;
  //logic [9:0] vs_count;
  logic hs_pulse,vs_pulse,hs_disp,vs_disp;

  vga_ctrl v1(.clk(CLOCK_50),.*);

  initial begin
  $monitor($time," HS=%b,VS=%b,blank=%b,col=%d,row=%d\n",
                   HS,VS,blank,col,row);
    
  /*$monitor($time," vs_count=%d,hs_count=%d,\n\
                     HS=%b,VS=%b,blank=%b,col=%d,row=%d\n",
                   vs_count,hs_count,HS,VS,blank,col,row);*/
  CLOCK_50 = 0;
  forever #1 CLOCK_50 = ~CLOCK_50;
  end

  initial begin
  reset <= 1;
  @(posedge CLOCK_50);
  @(posedge CLOCK_50);
  
  reset <= 0;
  @(posedge CLOCK_50);

  for (int i = 0; i < 2*833600; i++)
    @(posedge CLOCK_50);
  $finish;
  end

endmodule: vga_test
