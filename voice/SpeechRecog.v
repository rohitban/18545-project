
// simple testbench
module tb; 
  initial begin
      clock = 0; 
      forever #5 clock = ~clock; 
  end
  
  logic reset_L, record, sample, micData, micClk, micLRSel; 
  logic [1:0] match; 

  SpeechRecog sr(.clk(clock), .*);

  initial begin
    $monitor("", things);
    reset_L = 1; 
    record = 0;
    sample = 0; 
    micData = 0; 
    @(posedge clk);
    reset_L = 0; 
    for (int i=0; i<100; i++) begin
      @(posedge clk);

      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
    end

endmodule


/** Top module for speech recognition for Pacman Controls
 *  @author Xiaofan Li
 *  @author Rohit Banerjee
 *  @bug not implemented
 **/

module SpeechRecog (
  ////////////////////////	Clock Input	 	////////////////////////
  input	logic clk,			    // A 100 MHz clock from top
  input logic reset_L
  ////////////////////////	Push Button		////////////////////////
  input	logic record,       // uses a push button debounced from top module
  input logic sample,       // set if it's sample mode; unasserted if real mode
                            // probably uses a switch
  // Indication LEDs
  output logic [1:0]    match,        // 2-bit pattern to indicate which one it matched
  
  // audio signals from/to top module
  input logic           micData, 
  output logic          micClk, 
  output logic          micLRSel,
);


// TODO need to change 
assign micClk = clk; 

///////////////////////		RAM Interface	////////////////////////
// For Recorded voice samples/real mode --> Slow Ram
// For FFT-ed voice sample mode --> Fast Ram
// For FFT-ed voice real mode --> Slow Ram

// This module records the time-domain voice data
logic [7:0] ram_data;
logic ram_wr;
//sample_ram

// The recording module
logic rec_en;
voice_record vr(.enable(rec_en), .voice_data(micData), 
                .store_data(ram_data), .store_wr(ram_wr), .*);


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

endmodule


/** @brief This module will record the voice data bitstream into
 *  bytes in RAM. 
 *  
 *  The module will start recording when the enable bit is asserted. 
 *  It will record 128B of data for testing only. 
 *  We will either enlarge the RAM or slow down the clock later. 
 */
module voice_record
#(parameter WIDTH = 8)
(input logic clk, reset_L, 
 input logic enable,
 input logic voice_data, 

 output logic store_wr,
 output logic [WIDTH-1:0] store_data)

  enum logic [1:0] {STOP, RECORD, STORE} cur, next; 
  // counter
  logic cnt_en; 
  logic [11:0] count; 
  // byte to store
  logic shift_en, shift_clr;
  logic [WIDTH-1:0] voice; 


  // wait for enable
  always_ff @(posedge clk, negedge reset_L) begin
    if (~reset_L) 
      cur <= STOP; 
      count <= 12'd0;
    else 
      cur <= next; 

      // implement the counter
      if (cnt_en)
        count <= count + 1;
      else 
        count <= 0; 
      
      // implement the shift register
      if (shift_en) 
        voice_byte <= {voice[WIDTH-2:0], voice_data};
      else if (shift_clr) 
        voice <= 0;
      else 
        voice <= voice; 
  end

  
  // states
  always_comb begin
    next = cur; 
    cnt_en = 0;
    shift_clr = 0; 
    store_data = 0;
    store_wr = 0;
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
        end
        if (count == 1024) 
          next = STOP;
      end
    endcase
  end
endmodule

module sample_compare 
#(parameter ERROR = 5, WIDTH = 32) 
(input logic clk,			              // A 100 MHz clock from top
 input logic [WIDTH-1:0] data_ina,    // data stream A
 input logic [WIDTH-1:0] data_ina,    // data stream B
 input logic enable,                 // Start comparing
 output logic match);
  // nothing for now
  
endmodule
