

//Map memory addresses to registers
module mem_remap
    (input  logic [15:0] ram_addr,
     input  logic       wr_en,
     output logic [4:0] ld_freq_1,
     output logic [3:0] ld_freq_2, ld_freq_3,
     output logic       ld_vol_1, ld_vol_2, ld_vol_3,
     output logic       ld_index_1,ld_index_2, ld_index_3);

    always_comb begin
        ld_freq_1 = 0;
        ld_freq_2 = 0;
        ld_freq_3 = 0;

        ld_vol_1 = 0;
        ld_vol_2 = 0;
        ld_vol_3 = 0;

        ld_index_1 = 0;
        ld_index_2 = 0;
        ld_index_3 = 0;
        
        if(wr_en == 1'b1) begin
        case(ram_addr)
            //voice 1
            16'h5045: ld_index_1 = 1'b1;
            16'h5055: ld_vol_1 = 1'b1;

            16'h5050: ld_freq_1[0] = 1'b1;
            16'h5051: ld_freq_1[1] = 1'b1;
            16'h5052: ld_freq_1[2] = 1'b1;
            16'h5053: ld_freq_1[3] = 1'b1;
            16'h5054: ld_freq_1[4] = 1'b1;

            //voice 2
            16'h504a: ld_index_2 = 1'b1;
            16'h505a: ld_vol_2 = 1'b1;

            16'h5056: ld_freq_2[0] = 1'b1;
            16'h5057: ld_freq_2[1] = 1'b1;
            16'h5058: ld_freq_2[2] = 1'b1;
            16'h5059: ld_freq_2[3] = 1'b1;

            //voice 3
            16'h504f: ld_index_3 = 1'b1;
            16'h505f: ld_vol_3 = 1'b1;

            16'h505b: ld_freq_3[0] = 1'b1;
            16'h505c: ld_freq_3[1] = 1'b1;
            16'h505d: ld_freq_3[2] = 1'b1;
            16'h505e: ld_freq_3[3] = 1'b1;
            
        endcase
        
        end
    end

endmodule: mem_remap

//registers for storing frequencies
//Normally multiple memory addresses
module fa_reg
    #(parameter w = 4) 
    (input  logic       clk, rst,
     input  logic [7:0] cpu_data,
     input  logic [w-1:0] ld_freq,
     output logic [4*w-1:0] Q);

    logic [w-1:0][3:0] fa;
    

    generate
    genvar i;
    for(i = 0; i <w ; i++) begin
      register #(4) split_reg(.clk,
                              .reset(rst),
                              .en(ld_freq[i]),
                              .clr( ),
                              .D(cpu_data[3:0]),
                              .Q(fa[i]));

      assign  Q[i*4+3:i*4] = fa[i];

      end
    endgenerate
    

endmodule: fa_reg


//Make sure that the accumlator 
//is updated only every 96KHz(when hooked up to a 100Mhz clock)
module clk_count
    #(parameter w = 11, val = 11'd1042)
    (input logic clk, rst,
     output logic en);
     
     logic [w-1:0] count;
    
    assign en = (count==11'd1042);
    
    always_ff@(posedge clk, posedge rst)
        if(rst)
         count <= 0;
        else if(count >= val)
          count <= 0;
        else
          count <= count+1;
          
endmodule: clk_count

//TEST
/*
module father_mod
    (input  logic clk, rst,
     output logic [15:0] father_addr);
     
     logic [13:0] clk_count;
     
     always_ff@(posedge clk, posedge rst) begin
        if(rst) begin
            father_addr <= 0;
            clk_count <= 0;
        end
        else if(clk_count>=14'd9070) begin
            clk_count <= 0;
            if(father_addr>=16'd40947)
                father_addr <= 0;
            else
                father_addr <= father_addr + 1; 
        end
        else
            clk_count <= clk_count + 1;
     end
           
endmodule: father_mod
*/

module sound_reg
    #(parameter w = 4)
    //(input  logic [3:0] sw,//TEST
     (input  logic       clk,rst,
      input  logic [7:0] cpu_data,
      input  logic [w-1:0] ld_freq,
      input  logic         ld_vol,ld_index,
      output logic [3:0]   sample_val,
      output logic [3:0]   volume);
     //output logic [7:0]   test_out);//TEST

    logic [2:0] wave_index;
    logic [4*w-1:0] freq,  accum;

    //WAVE INDEX
    
    register #(3) wave_reg(.clk,
                           .reset(rst),
                           .clr( ),
                           .en(ld_index),
                           .D(cpu_data[2:0]),
                           .Q(wave_index));
    
    
    //assign wave_index = sw;
    
    //VOL
   
    register #(4) vol(.clk,
                      .reset(rst),
                      .clr( ),
                      .en(ld_vol),
                      .D(cpu_data[3:0]),
                      .Q(volume));
   
   
   //assign volume = 4'hF;

   //FREQ
   
   fa_reg #(w) fr_reg(.clk,
                      .rst,
                      .cpu_data,
                      .ld_freq,
                      .Q(freq));
   
   
   //assign freq = 'd32768;

   //ACCUM

   logic [4*w-1:0] accum_in;

   assign accum_in = accum + freq;

    logic en_accum;
    
    clk_count hz_96(.clk, .rst,
                    .en(en_accum));
                    
   register #(4*w) ac_reg(.clk,
                          .clr( ),
                          .reset(rst),
                          .D(accum_in),
                          .en(en_accum),//loads at 96khz
                          .Q(accum));

   //Access ROM
   logic [7:0] sample_addr;

   logic [4:0] sample_index;

   assign sample_index = accum[4*w-1:4*w-1-4];

   assign sample_addr = {wave_index,sample_index};

   //Sound ROM block here

   logic [7:0] sample_byte;
   
   sound_rom srom(.clka(clk),
                  .addra(sample_addr),
                  .douta(sample_byte));
                  
   assign sample_val = sample_byte[3:0];

   //TODO:
   //Testing
   
   /*
   logic [15:0] father_addr;
   
   father_mod fmod(.clk,.rst,.father_addr);
   
   //Add ROM
   father_rom from(.clka(clk),
                   .addra(father_addr),
                   .douta(test_out));
    */
    
endmodule: sound_reg


module sample_selector
    //(input  logic [3:0]  sw,//TEST
     (input  logic        clk, rst,
     input  logic        wr_en,
     input  logic [7:0]  cpu_data,
     input  logic [15:0] ram_addr,
     output logic [9:0]  sample_out);

    //TEST
    logic [7:0] test_out;
    
    //Voice 1
    

    logic [4:0] ld_freq_1;
    logic       ld_vol_1, ld_index_1;
    logic [3:0] vol_1, sample_1;

    sound_reg #(5) vc_1(.clk,
                        .rst,
                        
                         //.sw,//TEST
                         //.test_out(test_out),//TEST

                        .cpu_data,
                        .ld_freq(ld_freq_1),
                        .ld_vol(ld_vol_1),
                        .ld_index(ld_index_1),
                        .sample_val(sample_1),
                        .volume(vol_1));

    //Voice 2

    logic [3:0] ld_freq_2;
    logic       ld_vol_2, ld_index_2;
    logic [3:0] vol_2, sample_2;

    sound_reg #(4) vc_2(.clk,
    
                        //.sw,//TEST
                        //.test_out( ),

                        .rst,
                        .cpu_data,
                        .ld_freq(ld_freq_2),
                        .ld_vol(ld_vol_2),
                        .ld_index(ld_index_2),
                        .sample_val(sample_2),
                        .volume(vol_2));

   //Voice 3

    logic [3:0] ld_freq_3;
    logic       ld_vol_3, ld_index_3;
    logic [3:0] vol_3, sample_3;

    sound_reg #(4) vc_3(.clk,
                        .rst,
                        
                        //.sw,//TEST
                        //.test_out( ),
                        

                        .cpu_data,
                        .ld_freq(ld_freq_3),
                        .ld_vol(ld_vol_3),
                        .ld_index(ld_index_3),
                        .sample_val(sample_3),
                        .volume(vol_3));


   mem_remap remap(.ram_addr,
                   .wr_en,
                   .ld_freq_1,
                   .ld_freq_2,.ld_freq_3,
                   .ld_vol_1,.ld_vol_2,.ld_vol_3,
                   .ld_index_1,.ld_index_2,.ld_index_3);

   //TODO: add multiplier for output 
   //Multiply 6 4-bit values to get 3 8-bit sound outputs
   logic [7:0] voice_1_out, voice_2_out, voice_3_out;
   
   sound_mult vc1_mult(.CLK(clk),
                       .A(sample_1),
                       .B(vol_1),
                       .P(voice_1_out));
                       
    sound_mult vc2_mult(.CLK(clk),
                        .A(sample_2),
                        .B(vol_2),
                        .P(voice_2_out));
                        
    sound_mult vc3_mult(.CLK(clk),
                        .A(sample_3),
                        .B(vol_3),
                        .P(voice_3_out));
                        
                        
    //Only 1 voice for testing                    
    logic [7:0] sample_sum;
    
    assign sample_sum = voice_1_out+voice_2_out+voice_3_out;
    
    assign sample_out = {sample_sum,2'b0};                                
    
   
   
endmodule: sample_selector
