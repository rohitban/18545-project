//We are definitely getting audio input


/** Top module for speech recognition for Pacman Controls
 *  @author Xiaofan Li
 *  @author Rohit Banerjee
 *  @bug not implemented
 **/
module SpeechRecog (
  ////////////////////////	Clock Input	 	////////////////////////
  input	logic clk,			    // A 100 MHz clock from top
  input logic reset_L,
  ////////////////////////	Push Button		////////////////////////
  input	logic record,       // uses a push button debounced from top module
  input logic sample,       // set if it's sample mode; unasserted if real mode
                            // probably uses a switch
  // Indication LEDs
  output logic [1:0]    match,        // 2-bit pattern to indicate which one it matched
  
  input  logic [15:12]    sw,//TEST
  
  //output logic [15:0]    led,//TEST
  
  //Testing
  output logic           ram_wr,
   
  output logic [11:0]     ram_addr,
  output logic [31:0]   ram_data,ram_out,
  
  // audio signals from/to top module
  input logic           micData, 
  output logic          micClk);


// TODO need to change
sample_freq #(6,6'd42) div(.clk,.rst(~reset_L),
                              .div_clk(micClk));
/*
sample_freq #(6,6'd42) div(.clk,.rst(~reset_L),
                              .div_clk(micClk));
*/
///////////////////////		RAM Interface	////////////////////////
// For Recorded voice samples/real mode --> Slow Ram
// For FFT-ed voice sample mode --> Fast Ram
// For FFT-ed voice real mode --> Slow Ram

// This module records the time-domain voice data
//logic [31:0] ram_out, 
logic [31:0] up_out, down_out, left_out, right_out;
//logic ram_wr;

//logic [7:0] ram_addr;

//logic [11:0] access_addr;

//sample_ram

// The recording module
logic rec_en;

logic ld_up, ld_down, ld_left, ld_right;

assign rec_en = record;

//Assign ram load signals

assign ld_up = sw[12]&ram_wr;

assign ld_down = sw[13]&ram_wr;

assign ld_left = sw[14]&ram_wr;

assign ld_right = sw[15]&ram_wr;


//Determine whether we are recording voice samples
//or taking control input

logic control_in;

assign control_in = (sw=='d0);

/*
voice_record #(8) vr(.enable(rec_en), 
                     .voice_data(micData),
                      
                     .store_data(ram_data),
                     .store_wr(ram_wr),
                     .ram_addr,
                     
                      
                     .reset_L,
                     .clk);*/

PDM_control pdm_ctrl(.clk,
                     .rst(~reset_L),
                     
                     .control_in,
                     
                     //INPUTS FROM ALL RAMS
                     .ram_out,
                     .up_out,
                     .down_out,
                     .left_out,
                     .right_out,
                     
                     .match,
                     
                     .micData,
                     .enable(record),
                     .ram_wr,
                     .ram_data,
                     .ram_addr);
                     


sample_ram sam_ram(.clka(clk),
                   .dina(ram_data),
                   .douta(ram_out),
                   .wea(ram_wr&control_in),
                   .addra(ram_addr));
   

sample_ram up_ram(.clka(clk),
                  .dina(ram_data),
                  .douta(up_out),
                  .wea(ld_up),//TODO: connect
                  .addra(ram_addr));
                  
sample_ram down_ram(.clka(clk),
                    .dina(ram_data),
                    .douta(down_out),
                    .wea(ld_down),//TODO: connect
                    .addra(ram_addr));
                    
 sample_ram left_ram(.clka(clk),
                     .dina(ram_data),
                     .douta(left_out),
                     .wea(ld_left),//TODO: connect
                     .addra(ram_addr));
                     
sample_ram right_ram(.clka(clk),
                    .dina(ram_data),
                    .douta(right_out),
                    .wea(ld_right),//TODO: connect
                    .addra(ram_addr));                    


// This module stores the FFT-ed sample data
//fft_sample_ram
// This module stores the FFT-ed realtime recording
//fft_real_ram

// A comparison module btw fft_sample_ram and fft_real_ram
//sample_compare sc();

// Built in module for audio DAC_ADC
//AUDIO_DAC_ADC u4 (
//  // Audio Side
//  .oAUD_BCK(AUD_BCLK),
//  .oAUD_DATA(AUD_DACDAT),
//  .oAUD_LRCK(CLK),
//  .oAUD_inL(audio_inL), // audio data from ADC 
//  .oAUD_inR(audio_inR), // audio data from ADC 
//  .iAUD_ADCDAT(AUD_ADCDAT),
//  .iAUD_extL(audio_outL), // audio data to DAC
//  .iAUD_extR(audio_outR), // audio data to DAC
//  // Control Signals
//  .iCLK_18_4(AUD_CTRL_CLK),
//  .iRST_N(DLY_RST));
//
//// Built in module for on chip fast FFT
//FFTModule fftc (
//  .iReset(~KEY[0]),
//  .iStart(lc),
//  .iStateClk(NIOS_CLK),
//  .oSampAddr(sampleAddr),
//  .iSamp(sample),
//  .iReadAddr(fftaddr),
//  .iReadClock(NIOS_CLK),
//  .oPower(fftcoeff),
//  .oExp(fftlevel),
//  .oDone(fftcomplete));
//
//// FIXME not sure what's used for
//Reset_Delay r0 (
//  .iCLK(CLOCK_50),
//  .oRESET(DLY_RST)
//);
//
//// FIXME not sure why this is here 
//audiopll p1 (
//  .areset(~DLY_RST),
//  .inclk0(CLOCK_27),
//  .c0(AUD_CTRL_CLK)
//);
//

endmodule: SpeechRecog

module sample_freq
    #(parameter w = 14, clocks = 14'd12500)
    (input logic clk, rst,
     output logic div_clk);
    
    assign div_clk = ~(count < clocks/2);
    
    logic [w-1:0] count;
    
    always_ff@(posedge clk, posedge rst)
        if(rst)
            count <= 0;
        else if(count==clocks-'d1)
            count <= 0;
        else
            count <= count + 1;
     
     
endmodule: sample_freq



/** @brief This module will record the voice data bitstream into
 *  bytes in RAM. 
 *  
 *  The module will start recording when the enable bit is asserted. 
 *  It will record 128B of data for testing only. 
 *  We will either enlarge the RAM or slow down the clock later. 
 */
module voice_record
    #(parameter WIDTH = 8, ADDR_WIDTH = 7)
    (input logic clk, reset_L, 
    input logic enable,
    input logic voice_data, 

    output logic [ADDR_WIDTH-1:0] ram_addr,
    output logic store_wr,
    output logic [WIDTH-1:0] store_data);
  
  enum logic [1:0] {STOP, RECORD, STORE} cur, next; 
  
  // counter
  logic cnt_en; 
  logic [11:0] count; 
  // byte to store
  logic shift_en, shift_clr;
  logic [WIDTH-1:0] voice; 

  logic inc_addr;

  // wait for enable
  always_ff @(posedge clk, negedge reset_L) begin
    if (~reset_L) begin 
      cur <= STOP; 
      count <= 12'd0;
      ram_addr <= 'd0;
    end
    else begin
      cur <= next; 
      // implement the counter
      if (cnt_en)
        count <= count + 1;
      else begin
        count <= 0; 
        ram_addr <= 0;
      end

      // implement the shift register
      if (shift_en) 
        voice <= {voice[WIDTH-2:0], voice_data};
      else if (shift_clr) 
        voice <= 0;
      else 
        voice <= voice; 
      
      //Implementr addr strobe
      if(inc_addr)
        ram_addr <= ram_addr + 1;

    end
  end

  
  // states
  always_comb begin
    next = cur; 
    cnt_en = 0;
    shift_clr = 0; 
    store_data = 0;
    store_wr = 0;
    inc_addr = 0;
    case (cur) 
      STOP: begin
        if (enable) 
          next = RECORD; 
      end

      RECORD: begin
        cnt_en = 1; 
        if (count % WIDTH != 0)
          shift_en = 1;
        else begin
          shift_clr = 1; 
          // load the stuff
          store_data = voice;
          store_wr = 1;

          inc_addr = 1;
        end
        if (count == 1024) 
          next = STOP;
      end
    endcase
  end
  
endmodule: voice_record




