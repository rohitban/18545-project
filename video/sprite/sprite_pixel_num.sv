`define SPRITE_COL_HALF 4'd8

module sprite_pixel_num
    (input  logic [3:0] row, col,
     input  logic       xflip, yflip,
     output logic [7:0] pixel_num);

    logic firstHalfCol;

    logic [3:0] rowQuart;

    assign firstHalfCol = 0 <= col && col < `SPRITE_COL_HALF;
    
    always_comb begin
        rowQuart[0] = 0 <= row && row < 'd4;
        rowQuart[1] = 'd4 <= row && row < 'd8;
        rowQuart[2] = 'd8 <= row && row < 'd12;
        rowQuart[3] = 'd12 <= row && row <= 'd15;
    end

    //assign the initial zone blind to x and y flips
    logic [2:0] init_zone;

    always_comb begin
        if(firstHalfCol) begin
          casex(rowQuart)
            4'b1???: init_zone = 'd4;
            4'b01??: init_zone = 'd7;
            4'b001?: init_zone = 'd6;
            4'b0001: init_zone = 'd5;
          endcase
        end
        else begin
          casex(rowQuart)
            4'b1???: init_zone = 'd0;
            4'b01??: init_zone = 'd3;
            4'b001?: init_zone = 'd2;
            4'b0001: init_zone = 'd1;
          endcase
        end
    end

    /////////////////////////////////////////////

    //Now swap the zones based on x and y flips

    logic [2:0] xflip_zone;
    logic [2:0] yflip_zone;

    //first handle x flip

    logic [2:0] xflip_mod;

    assign xflip_mod = (init_zone >= 'd4)?init_zone-'d4:init_zone+'d4;
    
    assign xflip_zone = (xflip)?xflip_mod:init_zone;

    //now handle y flip

    assign yflip_zone = (yflip)?(xflip_zone[0])?xflip_zone-'d1:xflip_zone+'d1:
                                  xflip_zone;//do not modify if no yflip

    logic [2:0] zone;
    
    //used in further calculations
    assign zone = yflip_zone;
   
   //now handle pixel assignment
   logic [3:0] zoneColStart;
   logic [3:0] zoneRowStart;

   assign zoneColStart = {col[3],3'b0};

   assign zoneRowStart = {row[3:2],2'b0};

   //Determine relative position within zone
   logic [3:0] zoneRow, zoneCol;

   assign zoneRow = row - zoneRowStart;
   assign zoneCol = col - zoneColStart;

   //Determine flipped position
   logic [3:0] dRow, dCol;

   assign dRow = (yflip)?zoneRow:'d4-zoneRow-'d1;

   assign dCol = (xflip)?zoneCol:'d8-zoneCol-'d1;

   logic [7:0] zone_offset;

   assign zone_offset = {zone,5'b0};//zone*32

   assign pixel_num = {4'b0,dRow} + {2'b0,dCol,2'b0} + zone_offset;
   //pixel_num = dRow + 4*dCol + zone_offset

endmodule: sprite_pixel_num
