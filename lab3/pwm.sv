`include "lib.sv"

`define DS_50 14'd5000
`define TOTAL_CLKS 14'd10000

module pwm10kHz
    #(parameter ACTIVE_CLKS = `DS_50) 
    (input  logic rst, clk,
     output logic pwm_sig);

    logic [13:0] pwm_cnt;


    limit_counter #(14) lc(.clk,
                           .rst,
                           .en(1'b1),
                           .clr( ),
                           .limit(`TOTAL_CLKS),
                           .Q(pwm_cnt));
    

    assign pwm_sig = 0 <= pwm_cnt && pwm_cnt < ACTIVE_CLKS;


endmodule: pwm10kHz
