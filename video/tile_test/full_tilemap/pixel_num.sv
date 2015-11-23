
`define OFFSET 6'd32
`define MAX_COLS_INDEX 3'd7
`define HALF_ROWS 3'd4
`define MAX_ROWS_INDEX 3'd7

module pixel_num
    (input  logic [2:0] row_offset,
     input  logic [2:0] col_offset,
     output logic [5:0] pixel_num);

    logic [2:0] drow;
    logic [2:0] dcol;


    assign dcol = `MAX_COLS_INDEX-col_offset;

    always_comb begin
        if(row_offset < `HALF_ROWS) begin

          drow = `HALF_ROWS-3'd1-row_offset;

          pixel_num = {dcol,2'b00} + drow + `OFFSET;
        end

        else begin
          drow = `MAX_ROWS_INDEX-row_offset;
          //$display("Drow is %d\n",drow);

          pixel_num = {dcol,2'b00} + drow;
        end
    end


endmodule: pixel_num
