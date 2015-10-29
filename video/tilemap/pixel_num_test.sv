

module pixel_num_test;
    logic [2:0] row_offset, col_offset;
    logic [5:0] pixel_num;

    pixel_num num(.*);

    initial begin
        $monitor($time, " row=%d, col=%d, pix=%d",
                         row_offset,col_offset,pixel_num);
        row_offset = 'd0;
        col_offset = 'd0;
        #10;

        row_offset = 'd4;
        col_offset = 'd4;//should be 15

        #10;

        row_offset = 'd7;
        col_offset = 'd7;//should be 0

        #10;

        row_offset = 'd3;
        col_offset = 'd7;//should be 32

        #10;

        row_offset = 'd4;
        col_offset = 'd0;

        #10;

        $finish;

    end
endmodule: pixel_num_test
