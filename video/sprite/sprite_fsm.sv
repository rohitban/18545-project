`define SPRITES 8

`define X_OFFSET 16'h5060
`define SPRITE_OFFSET 16'h4FF0

module my_counter
    #(parameter w = 4)
    (input  logic clk, rst,
     input  logic clr, inc,
     output logic [w-1:0] count);

    always_ff@(posedge clk, posedge rst)
        if(rst)
          count <= 0;
        else if(clr)
          count <= 0;
        else if(inc)
          count <= count + 1;

endmodule: my_counter

module sprite_fsm
    (input  logic     clk, rst,
     input  logic     vblank,

     input  logic [7:0] sprite_RAM_din,
     
     output logic [`SPRITES-1:0] ld_x, ld_y,
     output logic [`SPRITES-1:0] ld_num_flips, ld_palette,
     output logic     rd_en,

     output logic [7:0] fsm_dout,
     output logic [31:0] palette_out,
     output logic [15:0] sprite_RAM_addr);

    //Set up states
    enum {INIT,PAL_ADDR,GET_X,GET_Y,GET_SPRITE,NEXT_SPRITE} cs, ns;

    always_ff@(posedge clk, posedge rst)
        if(rst)
          cs <= INIT;
        else
          cs <= ns;


    //INDEX counter

    logic inc,clr;
    logic [2:0] i;

    my_counter #(3) index(.clk,
                          .rst,
                          .inc,
                          .clr,
                          .count(i));
    
    //Palette address register

    logic ld_pal_addr;
    logic [7:0] palette_index;

    register #(8) pal_addr(.clk,
                            .D(sprite_RAM_din),
                            .en(ld_pal_addr),
                            .clr( ),
                            .reset(rst),
                            .Q(palette_index));

    //TODO: have palette ROM block hooked up to palette index
    assign palette_out = 32'h01234567;//need to change

    //addresses

    logic [15:0] x_addr, y_addr, sprite_addr, palette_addr;

    assign x_addr = `X_OFFSET + {12'b0,i,1'b0};

    assign sprite_addr = `SPRITE_OFFSET + {12'b0,i,1'b0};

    assign y_addr = x_addr + 16'd1;
    assign palette_addr = sprite_addr + 16'd1;

    always_comb begin
        //To RAM
        sprite_RAM_addr = 0;
        rd_en = 0;

        //to sprite regs
        ld_x = 0;
        ld_y = 0;
        ld_num_flips = 0;
        ld_palette = 0;

        ld_pal_addr = 0;

        //to counter
        inc = 0;
        clr = 0;
        
        //to sprite regs
        fsm_dout = 0;

        case(cs)
            INIT: begin
                ns = (vblank)?PAL_ADDR:INIT;

                //read from RAM
                if(vblank) begin
                  rd_en = 1;
                  sprite_RAM_addr = palette_addr;
                end
            end

            PAL_ADDR:begin
                ns = GET_X;
                
                //Get x next
                sprite_RAM_addr = x_addr;
                rd_en = 1;

                ld_pal_addr = 1;//latch palette index
            end

            GET_X: begin
                ns = GET_Y;

                //wait 1 more cycle for the
                //palette index to propagate to ROM

                //get x from RAM to reg
                ld_x[i] = 1'b1;
                fsm_dout = sprite_RAM_din;
                
                //Get y from RAM
                sprite_RAM_addr = y_addr;
                rd_en = 1'b1;
            end

            GET_Y: begin
                ns = GET_SPRITE;
               
                //get palette from ROM
                ld_palette[i] = 1'b1;

                //get y from RAM to reg
                fsm_dout = sprite_RAM_din;
                ld_y[i] = 1'b1;

                //get sprite, xflip and yflip from RAM
                sprite_RAM_addr = sprite_addr;
                rd_en = 1'b1;
            end

            GET_SPRITE: begin
                ns = NEXT_SPRITE;

                //read flip and sprite# into reg
                ld_num_flips[i] = 1'b1;
                fsm_dout = sprite_RAM_din;
            end

            NEXT_SPRITE: begin
                if(i < 3'd7) begin
                  ns = PAL_ADDR;
                  inc = 1;
                  sprite_RAM_addr = palette_addr + 16'h2;//next palette addr
                  rd_en = 1;
                end
                else if(i >= 3'd7 && ~vblank) begin
                  ns = INIT;
                  clr = 1'b1;
                end
                else
                  ns = NEXT_SPRITE;
            end

        endcase
    end




endmodule: sprite_fsm
