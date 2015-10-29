


module dr_demo_test;
    logic [9:0] col;
    logic [8:0] row;
    logic [3:0] red,green,blue;

    dr_demo dut(.*);

    initial begin
        $monitor($time," row=%d, col=%d,red=%h",
                        row,col,red);
        for(row=0;row<9'd7;row++) begin
          for(col=0;col<10'd7;col++) begin
            #10;
          end
        end
        #10;
        $finish;
    end

endmodule: dr_demo_test
