

module mem_test;

    logic [11:0] pix_addr;
    logic clk;
    logic [7:0] tile_byte;

    tile_rom t_rom(.addra(pix_addr),                                             
                  .clka(clk),                                                     
                  .douta(tile_byte),                                              
                  .ena(1'b1)); 

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        pixel_addr <= 0;
        @(posedge clk);
        pixel_addr <= 12'd4;
        @(posedge clk);
        @(posedge clk);
        $finish;
    end

endmodule: mem_test
