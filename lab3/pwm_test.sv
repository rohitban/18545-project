
`define DS_10 14'd1000

`define DS_70 14'd7000

module pwm_test;
    logic clk, rst, pwm_sig_10;

    pwm10kHz #(`DS_10) pwm1(.clk, .rst,
                           .pwm_sig(pw_sig_10));

    initial begin
        clk = 0;
        rst = 1;
        rst <= 0;
        forever #5 clk = ~clk;
    end

    initial begin
        for(int i = 0; i < 80000; i++) begin
          @(posedge clk);
        end
    end
                    
endmodule: pwm_test
