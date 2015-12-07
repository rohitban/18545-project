`define SAMPLE_FREQ 'd10000


module shifter
    #(parameter sample_w = 8)
    (input logic clk, rst,
     input logic count_en,
     input logic [sample_w-1:0] din,
     input logic shift_en,
     output logic [4*sample_w-1:0] ram_data);

    always_ff@(posedge clk, posedge rst)
        if(rst)
          ram_data <= 0;
        else if(count_en) begin
          if(shift_en)

            ram_data <= {ram_data[3*sample_w-1:0],din};
        end
        else 
          ram_data <= 0;

endmodule: shifter

module wr_ctrl
    (input logic clk, rst, count_en,
     input logic shift_en,
     output logic ram_wr);

    logic [1:0] count;
    
    always_ff@(posedge clk, posedge rst) begin
        if(rst) begin
          count <= 0;
        end
        else if(count_en) begin
          if(shift_en)
            count <= count + 1;
          else
            count <= count;
        end
        else
          count <= 0;
        
        if(rst)
          ram_wr <= 0;
        else if(count_en&&(count=='d3)&&shift_en)
          ram_wr <= 1;
        else
          ram_wr <= 0;
    end

endmodule: wr_ctrl

module PDM_sample
    #(parameter count_w = 8, clocks = 'd2_400_000/`SAMPLE_FREQ, sample_w = 8)
    (input logic clk,rst,//runs at a 2.4Mhz clock
     
     input logic count_en,
     input logic micData,

     output logic [4*sample_w-1:0] ram_data,
     output logic        ram_wr);

    logic [count_w-1:0] count;
    
    logic [sample_w-2:0] sample_count;
    logic                rec_en;
    logic shift_en;
    
    assign rec_en = (count < 2**(sample_w-'d1) - 'd1);    
    

    wr_ctrl control(.clk, .rst,.count_en,
                    .shift_en, .ram_wr);

    //Shift register
   

    shifter #(sample_w)  samp_shft(.clk,.rst,
                                   .count_en,
                                   .din({1'b0,sample_count}),
                                   .shift_en,
                                   .ram_data);


    assign shift_en = (count==2**(sample_w-1)-'d1);

    always_ff@(posedge clk, posedge rst) begin
        if(rst) begin
          count <= 0;
        end
        else if(count==clocks-'d1)
          count <= 0;
        else if(count_en)
          count <= count + 1;
        else
          count <= 0;

        //Set up sample counter
        if(rst)
          sample_count <= 0;
        else if(rec_en&&count_en)
          sample_count <= sample_count + micData;
        else
          sample_count <= 0;
    end
     
endmodule: PDM_sample
