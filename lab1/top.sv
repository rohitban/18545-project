
module top
   (input  logic [15:0] sw,
    input  logic        clk,
    input  logic        btnC,btnL,
    output logic [7:0]  an, // for segment demuxing
    output logic [15:0]      led,
    output logic [6:0]  seg);

    logic rst_b; 
    logic [15:0] result;
    logic [3:0][6:0] seg_data; 
    logic [7:0] shift_cnt;
    logic [1:0] cnt;  
    
    assign rst_b = ~btnL;
    assign an = ~shift_cnt;
     
    always_comb begin
        seg = seg_data[cnt]; 
    end

    always_ff @(posedge clk, negedge rst_b) begin
        if (~rst_b) begin 
            cnt <= 0; 
            shift_cnt <= 8'd1; 
        end
        else begin
            cnt <= cnt + 2'd1;
            if (shift_cnt == 8'b0000_1000) begin 
                shift_cnt <= 8'd1; 
            end
            else
                shift_cnt <= shift_cnt << 1;
        end
    end

    sum_fsm accum(.clk(clk),
                  .rst_b(rst_b),
                  .done(led[0]),
                  .num(sw),
                  .nxt(btnC),
                  .result(result));
    

    BCDtoSevenSegment seg0(.bcd(result[3:0]),
                           .segment(seg_data[0]));
  
    BCDtoSevenSegment seg1(.bcd(result[7:4]),
                           .segment(seg_data[1]));
 
    BCDtoSevenSegment seg2(.bcd(result[11:8]),
                           .segment(seg_data[2]));

    BCDtoSevenSegment seg3(.bcd(result[15:12]),
                           .segment(seg_data[3]));

endmodule: top



