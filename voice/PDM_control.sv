`include "PDM_sampler.sv"

`define CHUNKS 'd2830

module PDM_control
   #(parameter count_w = 8, clocks = 'd2_400_000/`SAMPLE_FREQ, sample_w = 8) 
    (input  logic clk, rst,
     input  logic micData,
     input  logic enable,
     output logic ram_wr,
     output logic [4*sample_w-1:0] ram_data,
     output logic [11:0] ram_addr);
    
    logic clr;

    enum {RECORD,STOP} cs,ns;
    
    logic [11:0] count;

    assign ram_addr = count;

    always_ff@(posedge clk, posedge rst) begin
        if(rst) begin
          cs <= STOP;
          count <= 0;
        end
        else begin
          cs <= ns;
          if(clr)
            count <= 0;
          else if(ram_wr)
            count <= count + 1;
        end
    end

    logic count_en;


    PDM_sample #(count_w,clocks,sample_w) sampler(.clk,.rst,
                                                  .count_en,
                                                  .micData,
                                                  .ram_data,
                                                  .ram_wr);

    always_comb begin
        clr = 0;
        count_en = 0;
        case(cs)
            STOP: begin
                ns = (enable)?RECORD:STOP;
                count_en = (enable)?1'b1:1'b0;
            end
            RECORD: begin
                ns = (count < `CHUNKS)?RECORD:STOP;
                count_en = (count<`CHUNKS)?(ram_wr)?1'b0:1'b1:1'b0;
                clr = (count<`CHUNKS)?1'b0:1'b1;
            end
        endcase
    end
endmodule: PDM_control
