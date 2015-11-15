

module pixel_data_dcd
    (input  logic [1:0] pixel_offset,
     input  logic [7:0] pixel_byte,
     output logic [1:0] pixel_data);

    logic [2:0] index_lo, index_hi;

    assign index_lo = {1'b0,pixel_offset};

    assign index_hi = {1'b0,pixel_offset} + 3'd4;

    assign pixel_data = {pixel_byte[index_hi],pixel_byte[index_lo]};

endmodule: pixel_data_dcd
