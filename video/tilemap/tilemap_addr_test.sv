


module tilemap_addr_tester;
    logic [8:0] row;
    logic [9:0] col;

    logic [15:0] raw_addr;

    tilemap_addr_dcd dut(.*);

    initial begin
        $monitor($time," row=%d,col=%d,addr=%h",
                 row, col, raw_addr);
        row = 0;
        col = 0;
        #10;
        row = 'd8*'d1;
        col = 'd8*'d10;//should be 03f3
        #10;
        row = 'd8*'d34;
        col = 'd8*'d8;//should be 0015
        #10;
        row = 'd8*'d35;
        col = 'd8*'d17;//should be 002c
        #10;
        row = 'd8*'d20;
        col = 'd8*'d7;//should be 02D2
        #10;
        row = 'd8*'d33;
        col = 'd8*'d19;//should be 015f
        #10;
        $finish;
    end

endmodule: tilemap_addr_tester
