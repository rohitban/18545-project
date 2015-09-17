


module sum_test;
 logic [15:0] num, result;

 logic        nxt, clk, rst_b, done;

 sum_fsm summer(.clk, .rst_b,
                .nxt, .done,
                .result,.num);

 initial begin
    clk = 0;
    rst_b = 0;
    rst_b <= 1;
    forever #5 clk = ~clk;
 end

 initial begin
   $monitor($time, " result=%h, num=%d, nxt=%b, done=%b",
             result, num, nxt, done);
    num <= 240;
    nxt <= 1;
    @(posedge clk);//START->NUM2
    
    num <= 2;
    nxt <= 0;
    @(posedge clk);//NUM2
    
    num <= 3;
    nxt <= 1;
    @(posedge clk);//NUM2->LAST_NUM

    num <= 4;
    nxt <= 1;
    @(posedge clk);
    
    nxt <= 1;
    @(posedge clk);
    $finish;
 end


endmodule: sum_test 
