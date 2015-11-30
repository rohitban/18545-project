
module pwm_counter
    #(parameter w = 11, max = 11'd1042) 
    (input  logic   clk, rst,
     output logic [w-1:0] count);

    always_ff@(posedge clk, posedge rst)
        if(rst)
          count <= 0;
        else if(count==max)
          count <= 0;
        else
          count <= count + 1;

endmodule: pwm_counter

module PWM_controller
    #(parameter w = 11, max = 11'd1042)
    (input  logic        clk,rst,
     input  logic [w-1:0] pwm_thresh,
     output logic        ampPWM,ampSD);

    //enable sound
    assign ampSD = 1'b1;

    logic [w-1:0] pwm_count;
    
    pwm_counter #(w,max) pwm(.clk,.rst,
                             .count(pwm_count));

    assign ampPWM = (pwm_count < pwm_thresh);

endmodule: PWM_controller
