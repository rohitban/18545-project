



module sample_test;
   logic clk, rst;

   logic wr_en;

   logic [7:0] cpu_data;

    logic [15:0] ram_addr;

    logic [7:0] sample_out;


    sample_selector dut(.*);

    initial begin
      clk = 0;
      rst = 1;
      rst <= 0;
      forever #5 clk = ~clk;
    end

    initial begin
        cpu_data <= 8'hAF;
        ram_addr <= 0;
        wr_en <= 0;
        @(posedge clk);

        wr_en <= 1;

        //Voice 1
        ram_addr <=16'h5045;
        @(posedge clk);

        ram_addr <= 16'h5055;
        @(posedge clk);

        ram_addr <= 16'h5050;
        @(posedge clk);
        ram_addr <= 16'h5051;
        @(posedge clk);
        ram_addr <= 16'h5052;
        @(posedge clk);
        ram_addr <= 16'h5053;
        @(posedge clk);
        ram_addr <= 16'h5054;
        @(posedge clk);

        wr_en <= 0;
        cpu_data <= 8'hBF;

        @(posedge clk);
        
        //Voice 2
        wr_en <= 1;
        ram_addr <= 16'h504a;

        @(posedge clk);

        ram_addr <= 16'h505a;
        @(posedge clk);

        ram_addr <= 16'h5056;
        @(posedge clk);

        ram_addr <= 16'h5057;
        @(posedge clk);
        ram_addr <= 16'h5058;
        @(posedge clk);
        ram_addr <= 16'h5059;
        @(posedge clk);

        //Voice 3
        wr_en <= 0;
        cpu_data <= 8'hCF;

        @(posedge clk);

        wr_en <= 1;
        ram_addr <= 16'h504f;
        @(posedge clk);
        ram_addr <= 16'h505f;
        @(posedge clk);
        ram_addr <= 16'h505b;
        @(posedge clk);
        ram_addr <= 16'h505c;
        @(posedge clk);
        ram_addr <= 16'h505d;
        @(posedge clk);
        ram_addr <= 16'h505e;
        @(posedge clk);

        wr_en <= 0;
        @(posedge clk);
        $finish;

    end


endmodule: sample_test
