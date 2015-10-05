
`include "pwm.sv"

`define DS_10 14'd1000

`define DS_80 14'd8000

module pwm_ctrl
    (input  logic       clk, rst,
     input  logic [1:0] sel,
     output logic       pwm_out);

    logic pwm_sig_10, pwm_sig_80;

    pwm10kHz #(`DS_10) pwm_10(.clk,
                              .rst,
                              .pwm_sig(pwm_sig_10));

    pwm10kHz #(`DS_80) pwm_80(.clk,
                              .rst,
                              .pwm_sig(pwm_sig_80));

    assign pwm_out = (sel[1])?pwm_sig_80:
                     (sel[0])?pwm_sig_10:
                     1'b0;

endmodule: pwm_ctrl
