

module top
    (input  logic clk, btnC,
     input  logic btnL, btnR,
     output logic ampPWM);

    pwm_ctrl pwm_mod(.clk,
                    .rst(btnC),
                    .sel({btnL,btnR}),
                    .pwm_out(ampPWM));
endmodule: top
