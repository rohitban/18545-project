



module PDM_ctrl_test;
    logic clk, rst;

    logic micData;

    logic enable;

    logic ram_wr;

    logic [31:0] ram_data;

    logic [11:0] ram_addr;

    PDM_control dut(.*);

   initial begin
    clk = 0;
    rst = 1;
    rst <= 0;
    forever #5 clk = ~clk;
   end

   initial begin
    micData <= 1;
    enable <= 0;
    @(posedge clk)

    enable <= 1;
    @(posedge clk);
   
    enable <= 0;
    for(int i = 0 ; i < 5000; i++)
      @(posedge clk);

    $finish;

   end
    
endmodule: PDM_ctrl_test
