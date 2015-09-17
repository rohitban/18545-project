
module register
    #(parameter W = 16)
    (input  logic [W-1:0] D,
     input  logic         ld, clr,
     input  logic         clk, rst_b,
     output logic [W-1:0] Q);

    always_ff@(posedge clk, negedge rst_b)
        if(~rst_b)
          Q <= 0;
        else if(clr)
          Q <= 0;
        else if(ld)
          Q <= D;

endmodule: register


//Sum 3 numbers and then assert done
//the sum of the 16 bit numbers is result
module sum_fsm
    (input  logic [15:0] num,
     input  logic        nxt,
     input  logic        clk, rst_b,
     output logic        done,
     output logic [15:0] result);

    logic [15:0] add_out;
    logic        ld;

    assign add_out = num + result;

    enum {START, NUM2, LAST_NUM} cs, ns;

    register #(16) accum(.clk,.rst_b,
                         .ld,
                         .clr( ),
                         .Q(result),
                         .D(add_out));
                         
    always_ff@(posedge clk, negedge rst_b)
        if(~rst_b)
          cs <= START;
        else
          cs <= ns;

    always_comb begin
       ld = 0;
       done = 0;
       case(cs)
         START:begin
            ns = (nxt)?NUM2:START;
            ld = (nxt)?1'b1:1'b0;
         end
         
         NUM2: begin
            ns = (nxt)?LAST_NUM:NUM2;
            ld = (nxt)?1'b1:1'b0;
         end

         LAST_NUM: begin
            ns = LAST_NUM;
            ld = (nxt)?1'b1:1'b0;
            done = (nxt)?1'b1:1'b0;
         end

       endcase
    end


endmodule: sum_fsm
