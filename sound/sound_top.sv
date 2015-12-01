

module sound_top
    (input  logic clk, btnC, btnL,btnR,
     //input  logic [3:0] sw,
     output logic ampPWM, ampSD);
    
    logic [7:0] cpu_data;//change to actual data
    logic [15:0] ram_addr;
    
    assign ram_addr  = 0;  
    
    assign cpu_data = 'd0;
    
    
    logic rst, wr_en;
    
    
    
    //TODO: change to actual input
    assign wr_en = btnL;
        
    assign rst = btnC;
    
    //Select the sample to be played
    logic [9:0] sample_out;
    
    sample_selector samp_sel(.clk,
    
                             //.sw,//test
                             
                             .rst,
                             .ram_addr,
                             .cpu_data,
                             .sample_out);
                             
    //Create threshold value
    logic [10:0] pwm_thresh;//change to 10:0 for actual
    
    
    pwm_thresh_96k pthresh(.mult_val(sample_out),
                                .pwm_thresh);
                            
                            
    //Create pwm control stuff
    logic amp;
    
    assign ampPWM = amp&btnR;
        
    PWM_controller #(11,11'd1042)PWM_ctrl(.clk,
                                          .rst,
                                          .pwm_thresh,
                                          .ampPWM(amp),
                                          .ampSD);
    
                            
endmodule: sound_top
