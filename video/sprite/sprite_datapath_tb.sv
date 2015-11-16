
module sprite_fsm_tb;
    logic clk, rst;

    logic vblank;//input
    logic [7:0] sprite_RAM_din;//input

    logic rd_en;

    logic [15:0] sprite_RAM_addr;

    logic [3:0] sprite_r,sprite_g,sprite_b;

    logic [8:0] row;
    logic [9:0] col;

    sprite_datapath spr_dp(.clk,.rst,.vblank,
                           .row,.col,

                           //Read from RAM
                           .sprite_RAM_din,
                           .rd_en,
                           .sprite_dp_RAM_addr(sprite_RAM_addr),
                           
                           //colors
                           .sprite_r,
                           .sprite_g,
                           .sprite_b);

    
    logic [7:0] data_in;

    assign data_in = (rd_en)?8'hFF:8'h0;

    //1 cycle delay
    always_ff@(posedge clk, posedge rst)
        if(rst)
          sprite_RAM_din <= 0;
        else
          sprite_RAM_din <= data_in;

    initial begin
        clk = 0;
        rst = 1;
        rst <= 0;
        forever #5 clk = ~clk;
    end

    initial begin
        row <= 0;
        col <= 0;
        vblank <= 0;
        @(posedge clk);

        vblank <= 1;
        @(posedge clk);//>PAL_ADDR

        for(int j =0; j < 9;j++) begin
            @(posedge clk);//>GET_X

            @(posedge clk);//>GET_Y

            @(posedge clk);//>GET_SPRITE

            @(posedge clk);//>NEXT_SPRITE

            @(posedge clk);//>PAL_ADDR
        end
        $finish;
    end


endmodule: sprite_fsm_tb
