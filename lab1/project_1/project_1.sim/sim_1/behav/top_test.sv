

module top_test;
    logic [15:0] sw;
    logic        clk, nxt, rst_b;
    logic [7:0]  an;
    logic [6:0]  seg;
    logic [15:0] led;
    logic [15:0] result;

    logic done;

    assign done = led[0];
    top dut(.sw,
            .clk,
            .btnL(rst_b),
            .btnC(nxt),
            .an,
            .result,
            .led,
            .seg);

    initial begin
        clk = 0;
        rst_b = 0;
        rst_b <= #1 1;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor($time," result=%d,seg=%b,shift=%b,nxt=%b,sw=%d,done=%b",
                        result,seg,~an,nxt,sw,done);
        sw <= 1;
        nxt <= 1;
        @(posedge clk);
        sw <= 5;
        nxt <= 1;
        @(posedge clk);
        sw <= 10;
        nxt <= 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end

    

endmodule: top_test
