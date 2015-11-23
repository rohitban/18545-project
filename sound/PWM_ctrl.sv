
module pwm_counter
    (input  logic   clk, rst,
     output logic [26:0] count);

    always_ff@(posedge clk, posedge rst)
        if(rst)
          count <= 0;
        else if(count==24'd100_000_000)
          count <= 0;
        else
          count <= count + 1;

endmodule: pwm_counter

module PWM_controller
    (input  logic        clk,rst,
     input  logic [26:0] pwm_thresh,
     output logic        ampPWM,ampSD);

    //enable sound
    assign ampSD = 1'b1;

    logic [26:0] pwm_count;
    
    pwm_counter pwm(.clk,.rst,
                    .count(pwm_count));

    assign ampPWM = (pwm_count < pwm_thresh);

endmodule PWM_controller
