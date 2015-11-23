

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

//registers for 
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

module sound_reg
    #(parameter w = 4)
    (input  logic       clk,rst,
     input  logic [7:0] cpu_data,
     input  logic [w-1:0] ld_freq,
     input  logic         ld_vol,ld_index,
     output logic [3:0]   sample_val,
     output logic [3:0]   volume);

    logic [2:0] wave_index;
    logic [4*w-1:0] freq,  accum;

    //WAVE INDEX
    register #(3) wave_reg(.clk,
                           .reset(rst),
                           .clr( ),
                           .en(ld_index),
                           .D(cpu_data[2:0]),
                           .Q(wave_index));
    //VOL
    register #(4) vol(.clk,
                      .reset(rst),
                      .clr( ),
                      .en(ld_vol),
                      .D(cpu_data[3:0]),
                      .Q(volume));

   //FREQ

   fa_reg #(w) fr_reg(.clk,
                      .rst,
                      .cpu_data,
                      .ld_freq,
                      .Q(freq));

   //ACCUM

   logic [4*w-1:0] accum_in;

   assign accum_in = accum + freq;

   register #(4*w) ac_reg(.clk,//96khz
                          .clr( ),
                          .reset(rst),
                          .D(accum_in),
                          .en(1'b1),
                          .Q(accum));

   //Access ROM
   logic [7:0] sample_addr;

   logic [4:0] sample_index;

   assign sample_index = accum[4*w-1:4*w-1-4];

   assign sample_addr = {wave_index,sample_index};

   //Insert Sound ROM block here

   logic [7:0] sample_byte;


endmodule: sound_reg


module sample_selector
    (input  logic        clk, rst,
     input  logic        wr_en,
     input  logic [7:0]  cpu_data,
     input  logic [15:0] ram_addr,
     output logic [9:0]  sample_out);

    
    //Voice 1
    
    logic [4:0] ld_freq_1;
    logic       ld_vol_1, ld_index_1;
    logic [3:0] vol_1, sample_1;

    sound_reg #(5) vc_1(.clk,
                        .rst,
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

     
endmodule: sample_selector
