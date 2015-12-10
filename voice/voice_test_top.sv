
//For simulating the voice top module
module voice_tb;
    logic clk, btnC;//clk and reset
    logic btnR;//record button
    
    logic micData,micClk,micLRSel;
    
    logic [3:0] sw;
    logic [1:0] led;
    
    voice_test_top dut(.*);
    
    initial begin
        clk = 0;
        btnC = 1;
        btnC <= 0;
        forever #5 clk = ~clk;
    end
    
    
    initial begin
        btnR = 0;
        micData <= 1;
        for(int i =0;i<100;i++)
            @(posedge clk);//wait for pll to sync
        
        // record up
        sw = 4'b0001;
        // record sample
        btnR = 1;
        @(posedge clk);
        for(int i =0;i<100;i++) begin 
            micData <= ~micData;
            @(posedge clk);//wait for pll to sync
        end
        
        for(int i =0;i<100;i++)
            @(posedge clk);//wait for pll to sync
        
        btnR = 0;
        @(posedge clk);
        @(posedge clk);

        // test sample
        sw = 4'b0000;
        // record sample
        btnR = 1;
        @(posedge clk);
        for(int i =0;i<100;i++) begin 
            micData <= ~micData;
            @(posedge clk);//wait for pll to sync
        end

        $finish;
    end
    
    
    
endmodule: voice_tb


module voice_test_top
    (input  logic clk, btnC,//clk and reset
     input  logic btnR,//record button
     
     input  logic micData,
     output logic micClk,
     output logic micLRSel,
     
     input  logic [3:0] sw, // 15:12

     output logic [1:0] led);
     
     logic ram_wr;
     
     logic control_in;
     
     assign control_in = (sw =='d0);
     
     logic [31:0] ram_data, ram_out;
     
     logic [11:0] ram_addr;
     
     logic reset_L;
     
     assign reset_L = ~btnC;
     
     assign micLRSel = 0;
     
     SpeechRecog spch(.clk,
                      .reset_L(~btnC),
                 
                      .sw,//TEST
                      //.led,//TEST
                       
                       .ram_wr,
                       .ram_data,
                       .ram_out,
                       .ram_addr,
                       
                      .record(btnR),
                 
                      .sample( ),
                 
                      .match(led[1:0]),
                 
                      .micData,
                      .micClk);
     
//     mic_ila ila(.clk(clk),
//             .probe0(micData),
//             .probe1(micClk),
//             .probe2(ram_wr),
//             .probe3(ram_data),
//             .probe4(ram_out),
//             .probe5(ram_addr),
//             .probe6(control_in));
    
endmodule: voice_test_top
