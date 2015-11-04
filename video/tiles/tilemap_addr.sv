`define TOP_OFFSET 16'h3C2
`define BOTTOM_OFFSET 16'h002
`define MID_OFFSET 16'h040


`define TILEMAP_ROWS 6'd36
`define TILEMAP_COLS 5'd28

`define EXTENDED_COLS 16'd28

//raw addresses are between 0-3ff
module tilemap_addr_dcd
    (input  logic [8:0] row,
     input  logic [9:0] col,
     output logic [15:0] raw_addr);

    logic [5:0] tile_row;
    logic [4:0] tile_col;

    logic [15:0] d_col_ext;
    logic [15:0] d_row_mid;
    logic [15:0] d_col_mid;

    logic [4:0]  col_offset;

    logic        horz_level;
    logic [15:0] inc_horz_row;

    //discard the lowest 3 bits(divide by 8)
    //tile rows are between 0 and 35
    assign tile_row = row[8:3];

    //tile cols are between 0 and 27
    //for all rows except the 1st 2 rows and last 2
    //rows, for these, tile cols are b/w 0 and 32
    assign tile_col = col[7:3];

    assign horz_level = (tile_row=='d1)||
                        (tile_row==`TILEMAP_ROWS-'d1);
    
    assign inc_horz_row = {9'b0,horz_level,5'b0};


    //for the top 2 and bottom 2 rows
    assign d_col_ext = `EXTENDED_COLS -16'd1 - {11'b0,tile_col};

    //for the middle part
    assign d_row_mid = {10'b0,tile_row} - 16'd2;
    assign col_offset = `TILEMAP_COLS -5'd1 - tile_col;

    assign d_col_mid = {6'b0,col_offset,5'b0};

    always_comb begin
        if(0 <= tile_row && tile_row < 2) 
            raw_addr = `TOP_OFFSET + d_col_ext + inc_horz_row; 
        else if(`TILEMAP_ROWS-2 <= tile_row && tile_row < `TILEMAP_ROWS)
            raw_addr = `BOTTOM_OFFSET + d_col_ext + inc_horz_row;
        else begin//everything except the 1st 2 and last 2 rows
            //row is between 2 and 33
            //col is between 0 and 27
            raw_addr = `MID_OFFSET + d_col_mid + d_row_mid;
        end
        
    end

endmodule: tilemap_addr_dcd
