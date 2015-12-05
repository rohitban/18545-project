/*
module voice_tb;
    logic clk, btnC;
    
    logic btnL, enable;
    assign btnL = enable;
    
    logic micData,micClk,micLRSel;
    
    logic [7:0] sw;
    logic [7:0] led;
    
    assign sw = 0;
    
    voice_test_top dut(.*);
    
    initial begin
        clk = 0;
        btnC = 1;
        btnC <= 0;
        forever #5 clk = ~clk;
    end
    
    
    initial begin
        enable <= 0;
        micData <= 1;
        for(int i =0;i<100;i++)
            @(posedge clk);//wait for pll to sync
        
        enable <= 1;
        @(posedge clk);
        
        enable <= 0;
        for(int i = 0; i < 2048;i++)
            @(posedge clk);
        $finish;
    end
    
    
    
endmodule: voice_tb
*/

module voice_test_top
    (input  logic clk, btnC,//clk and reset
     input  logic btnR,//record button
     
     input  logic micData,
     output logic micClk,
     output logic micLRSel,
     
     input  logic [12:0] sw,
     output logic [15:0] led);
     
     logic ram_wr;
     
     logic [31:0] ram_data;
     
     logic reset_L;
     
     assign reset_L = ~btnC;
     
     assign micLRSel = 0;
     
     SpeechRecog spch(.clk,
                      .reset_L(~btnC),
                 
                      .sw,//TEST
                      .led,//TEST
                       
                       .ram_wr,
                       .ram_data,
                       
                      .record(btnR),
                 
                      .sample( ),
                 
                      .match( ),
                 
                      .micData,
                      .micClk);
     
     mic_ila ila(.clk(clk),
             .probe0(micData),
             .probe1(micClk),
             .probe2(ram_wr),
             .probe3(ram_data));
    
endmodule: voice_test_top