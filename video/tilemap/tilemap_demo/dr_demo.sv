`include "pixel_data.sv"
`include "pixel_num.sv"


`define TILE0 64'h0011_3344_4466_3311_00cc_ee33_1111_eecc



module dr_demo
    (input  logic [9:0] col,
     input  logic [8:0] row,
     output logic [3:0] red,green,blue);

    logic [5:0] pixel_num;
    logic [3:0] byte_offset;
    logic [7:0] pixel_byte;

    logic [1:0] pixel_data;

    logic [64:0] tile;

    pixel_num num(.row_offset(row[2:0]),
                  .col_offset(col[2:0]),
                  .pixel_num);

    assign byte_offset = pixel_num[5:2];
    
    //statically define output bytes
    always_comb begin
        case(byte_offset)
            4'h0: pixel_byte = 8'hcc;
            4'h1: pixel_byte = 8'hee;
            4'h2: pixel_byte = 8'h11;
            4'h3: pixel_byte = 8'h11;
            4'h4: pixel_byte = 8'h33;
            4'h5: pixel_byte = 8'hee;
            4'h6: pixel_byte = 8'hcc;
            4'h7: pixel_byte = 8'h00;
            4'h8: pixel_byte = 8'h11;
            4'h9: pixel_byte = 8'h33;
            4'hA: pixel_byte = 8'h66;
            4'hB: pixel_byte = 8'h44;
            4'hC: pixel_byte = 8'h44;
            4'hD: pixel_byte = 8'h33;
            4'hE: pixel_byte = 8'h11;
            4'hF: pixel_byte = 8'h00;
        endcase
    end

    pixel_data_dcd dat(.pixel_offset(pixel_num[1:0]),
                       .pixel_byte,
                       .pixel_data);

    //assign colors
    assign red = (pixel_data==2'd0)?4'h0:4'hF;
    assign green = 4'h0;
    assign blue = 4'h0;

endmodule: dr_demo
