

`define CHUNKS 'd2830

`define UP 'd0
`define LEFT 'd1
`define RIGHT 'd2
`define DOWN 'd3

`define DIRS 'd4

`define SAMPLE_FREQ 'd10000

module PDM_control
   #(parameter count_w = 8, clocks = 'd2_400_000/`SAMPLE_FREQ, sample_w = 8) 
    (input  logic clk, rst,
     input  logic micData,
     
     input  logic control_in,
     
     //GET INPUTS FROM ALL RAM BLOCKS
     input  logic [31:0] ram_out, up_out, down_out, left_out, right_out,
     
     output logic [1:0] match,
     
     input  logic enable,
     output logic ram_wr,
     output logic [4*sample_w-1:0] ram_data,
     output logic [11:0] ram_addr);
    
    logic clr;
    
    //ADDR
        logic [11:0] count;
        
        
        //COMPARE TO DIRECTIONS
        logic incr;
        
        logic       clr_counts;    
        logic [3:0] en_count;
        
        logic [3:0][11:0] match_count;

    enum {RECORD,STOP,COMPARE} cs,ns;
    
    
    
    generate begin
        genvar i;
        for(i = 0; i < `DIRS ; i++)
            
            match_counter #(12) mcount(.clk,
                                       .rst,
                                       .clr(clr_counts),
                                       .en(en_count[i]),
                                       .count(match_count[i]));
    end
    endgenerate
    
    //MATCHER
    
    matcher mat(.match_count,
                .match);
    
    //////////////////////////////////////////////////
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
          else if(ram_wr||incr)
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
        //RECORD
        clr = 0;
        count_en = 0;
        
        //COMPARE
        clr_counts = 0;
        en_count = 0;
        incr = 0;
        case(cs)
            STOP: begin
                ns = (enable)?RECORD:STOP;
                count_en = (enable)?1'b1:1'b0;
                clr_counts = (enable)?1'b0:1'b1;
            end
            RECORD: begin
                ns = (count < `CHUNKS)?RECORD:(control_in)?COMPARE:STOP;
                count_en = (count<`CHUNKS)?(ram_wr)?1'b0:1'b1:1'b0;
                clr = (count<`CHUNKS)?1'b0:1'b1;
            end
            
            COMPARE: begin
                ns = (count < `CHUNKS)?COMPARE:STOP;
                incr = (count < `CHUNKS)?1'b1:1'b0;
                clr = (count<`CHUNKS)?1'b0:1'b1;
                
                if(ram_out==up_out)
                    en_count[`UP] = 1'b1;
                if(ram_out==down_out)
                    en_count[`DOWN] = 1'b1;
                if(ram_out==left_out)
                    en_count[`LEFT] = 1'b1;
                if(ram_out==right_out)
                    en_count[`RIGHT] = 1'b1;
            end
            
        endcase
    end
endmodule: PDM_control

module matcher
    (input logic [3:0][11:0] match_count,
     output logic [1:0] match);
     
     logic l_max, r_max , u_max, d_max;
     
     always_comb begin
        l_max = (match_count[`LEFT] > match_count[`RIGHT]) &&
                (match_count[`LEFT] > match_count[`UP]) &&
                (match_count[`LEFT] > match_count[`DOWN]);
                
        r_max = (match_count[`RIGHT] > match_count[`LEFT]) &&
                (match_count[`RIGHT] > match_count[`UP]) &&
                (match_count[`RIGHT] > match_count[`DOWN]);
        
        u_max = (match_count[`UP] > match_count[`LEFT]) &&
                (match_count[`UP] > match_count[`RIGHT]) &&
                 (match_count[`UP] > match_count[`DOWN]);
                 
        d_max = (match_count[`DOWN] > match_count[`LEFT]) &&
                (match_count[`DOWN] > match_count[`RIGHT]) &&
                (match_count[`DOWN] > match_count[`UP]);        
     end
     
     always_comb
        case({d_max,r_max,l_max,u_max})
            4'b0001: match = `UP;
            4'b0010: match = `LEFT;
            4'b0100: match = `RIGHT;
            4'b1000: match = `LEFT;
            default: match = `LEFT;
        endcase
     
endmodule: matcher

module match_counter
    #(parameter w = 12)
    (input  logic clk, rst,
     input  logic clr, en,
     output  logic [w-1:0] count);
     
     always_ff@(posedge clk, posedge rst)
        if(rst)
            count <= 0;
        else if(clr)
            count <= 0;
        else if(en)
            count <= count + 1;
             
endmodule: match_counter
