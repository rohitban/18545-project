

`define CHUNKS 'd2830

`define THRESH 'd15

`define UP 'd0
`define LEFT 'd1
`define RIGHT 'd2
`define DOWN 'd3

`define THRESH 'd3

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
        logic [3:0] inc_dir;
        logic [3:0][2:0] dir_add;

        
        logic [3:0][13:0] match_count;
    
    //Thresh comparators//

    thresh_comp #(`THRESH) up_comp(.ram_data(ram_out),
                                   .dir_data(up_out),
                                   .add_val(dir_add[`UP]));

   thresh_comp #(`THRESH) left_comp(.ram_data(ram_out),
                                   .dir_data(left_out),
                                   .add_val(dir_add[`LEFT]));

   thresh_comp #(`THRESH) right_comp(.ram_data(ram_out),
                                   .dir_data(right_out),
                                   .add_val(dir_add[`RIGHT]));

 
   thresh_comp #(`THRESH) down_comp(.ram_data(ram_out),
                                   .dir_data(down_out),
                                   .add_val(dir_add[`DOWN]));

      
    /////////////////////////////////////////////////////////
    
    generate begin
        genvar i;
        for(i = 0; i < `DIRS ; i++)
            //keep track of the match tallys
            match_counter #(14) mcount(.clk,
                                       .rst,
                                       .clr(clr_counts),
                                       .en(inc_dir[i]),

                                       .add_val({11'b0,dir_add[i]}),

                                       .count(match_count[i]));
    end
    endgenerate
    
    //MATCHER
    
    logic [1:0] match_in;
    logic       ld_match;

    matcher mat(.match_count,
                .match(match_in));
   

    always_ff@(posedge clk, posedge rst) begin
        if(rst)
          match <= `LEFT;
        else if(ld_match)
          match <= match_in;
    end
    //////////////////////////////////////////////////

    //access the ram with the count at any point in time
    assign ram_addr = count;

    //FSM states
    enum {RECORD,STOP,COMPARE} cs,ns;

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
            //The count can be increased either by the
            //sampler(ram_wr) while recording data
            //or by the local fsm(while comparing data)
        end
    end

    logic count_en;


    PDM_sample #(count_w,clocks,sample_w) sampler(.clk,.rst,
                                                  .count_en,
                                                  .micData,
                                                  .ram_data,
                                                  .ram_wr);

    thresh_comp #(15) t_up(ram_out, up_out, up_val); 
    thresh_comp #(15) t_down(ram_out, down_out, down_val); 
    thresh_comp #(15) t_left(ram_out, left_out, left_val); 
    thresh_comp #(15) t_right(ram_out, right_out, right_val); 
    
    
    always_comb begin
        //RECORD
        clr = 0;
        count_en = 0;
        
        //COMPARE
        clr_counts = 0;
        inc_dir = 0;
        incr = 0;
        ld_match = 0;

        case(cs)
            STOP: begin
                ns = (enable)?RECORD:STOP;
                count_en = (enable)?1'b1:1'b0;
                clr_counts = (enable)?1'b0:1'b1;
            end
            RECORD: begin
                //Allow the PDM sampler to record
                //until the desired # of chunks has been
                //reached by asserting the count_en line
                //One done, clear the counter
                ns = (count < `CHUNKS)?RECORD:(control_in)?COMPARE:STOP;
                count_en = (count<`CHUNKS)?(ram_wr)?1'b0:1'b1:1'b0;
                clr = (count<`CHUNKS)?1'b0:1'b1;
            end
            
            COMPARE: begin
                ns = (count < `CHUNKS)?COMPARE:STOP;
                incr = (count < `CHUNKS)?1'b1:1'b0;
                clr = (count<`CHUNKS)?1'b0:1'b1;


                //Load the register that holds the match
                //value
                ld_match = (count<`CHUNKS)?1'b0:1'b1;
                
                //increment all of the match tallys
                //by the increment that the thresh_comp
                //outputs
                inc_dir = (count<`CHUNKS)?4'hf:4'h0;
            end
            
        endcase
    end
endmodule: PDM_control

//Get the maximum tally
//In case of no max, choose left
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

//Counter to keeps track of the match tallys
module match_counter
    #(parameter w = 14)
    (input  logic clk, rst,
     input  logic clr, en,
     input  logic [w-1:0] add_val,
     output  logic [w-1:0] count);
     
     always_ff@(posedge clk, posedge rst)
        if(rst)
            count <= 0;
        else if(clr)
            count <= 0;
        else if(en)
            count <= count + add_val;
             
endmodule: match_counter
