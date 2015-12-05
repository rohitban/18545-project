

module PDM_test;

    logic count_en;
    
    logic micData;

    logic clk, rst;

    logic [31:0] ram_data;

    logic ram_wr;

    PDM_sample dut(.*); 

    initial begin
        clk = 0;
        rst = 1;
        rst <= 0;
        forever #5 clk = ~clk;
    end

    initial begin
        micData <= 1;
        count_en <= 0;
        @(posedge clk);
        
        count_en <= 1;
        for(int i = 0; i < 2000; i++)
          @(posedge clk);
        $finish;
    end
endmodule: PDM_test
