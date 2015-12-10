

//Checks to see how many bytes of the
//2 32 bit inputs are within a certain threshold of each other
module thresh_comp
    #(parameter val = 'd15)
    (input  logic [31:0] ram_data, dir_data,
     output logic [2:0] add_val);

    logic [3:0][7:0] ram_bytes;
    logic [3:0][7:0] dir_bytes;
    
    logic [3:0][2:0] thresh_ok;
    
    generate begin
    genvar i;
        for(i = 0;i < 'd4;i++) begin
            //split 32 bit chunk into bytes
            assign ram_bytes[i] = ram_data['d8*(i+1)-'d1:'d8*i];
            assign dir_bytes[i] = dir_data['d8*(i+1)-'d1:'d8*i];
            
            //check to see if values are within a threshold
            abs_check #(val) abs(.dir_bytes(dir_bytes[i]),
                          .ram_bytes(ram_bytes[i]),
                          .thresh_ok(thresh_ok[i]));
        end
    end

    endgenerate

    //gie the number of bytes within the threshold
    assign add_val = thresh_ok[0] + thresh_ok[1] + thresh_ok[2] + thresh_ok[3];

endmodule: thresh_comp

module abs_check
    #(parameter val = 'd15)
    (input  logic [7:0] dir_bytes, ram_bytes,
     output logic [2:0] thresh_ok);
    
    logic [7:0] diff, abs_diff;

    logic thresh_low;

    assign diff = dir_bytes - ram_bytes;

    //get the absolute value of the difference
    assign abs_diff = (diff[7])?(~diff+'d1):diff;

    //check to see if it is lower than the threshold
    assign thresh_low = (abs_diff <= val);

    assign thresh_ok = {2'b0,thresh_low};
endmodule: abs_check
