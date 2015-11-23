

module color_store
    (input  logic [3:0] color_index,
     input  logic       rst, clk,
     output logic [7:0] color_byte);

    logic [15:0][7:0] colors;

    always_ff@(posedge clk, posedge rst)
        if(rst) begin
          colors[0] <= 8'h00;
          colors[1] <= 8'h07;
          colors[2] <= 8'h66;
          colors[3] <= 8'hef;
          colors[4] <= 8'h00;
          colors[5] <= 8'hf8;
          colors[6] <= 8'hea;
          colors[7] <= 8'h6f;
          colors[8] <= 8'h00;
          colors[9] <= 8'h3f;
          colors[10] <= 8'h00;
          colors[11] <= 8'hc9;
          colors[12] <= 8'h38;
          colors[13] <= 8'haa;
          colors[14] <= 8'haf;
          colors[15] <= 8'hf6;
        end
    
    assign color_byte = colors[color_index];

endmodule: color_store
