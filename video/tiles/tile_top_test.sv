

module tile_blk_test;
    logic clk, rst;
    
    logic [8:0] row;
    
    logic [9:0] col;

    logic [15:0] palette_RAM_addr, tile_RAM_addr;

    tile_block dut(.clk,.rst,
                   .tile_ROM_addr( ),//hanging
                   .palette_ROM_addr( ),//hanging

                   .row,
                   .col,

                   .tile_RAM_addr,
                   .palette_RAM_addr,

                   .red( ),
                   .green( ),
                   .blue( ));

    initial begin
        clk = 0;
        rst = 1;
        rst <= 0;

        forever #5 clk = ~clk;
    end

    initial begin
        for(int i=0;i<480;i++) begin
          for(int j=0;j<640;j++)begin
            row <= i;
            col <= j;

            @(posedge clk);
            @(posedge clk);
            @(posedge clk);

            end
        end
        @(posedge clk);
        $finish;
    end

endmodule: tile_blk_test
