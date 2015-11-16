
module sprite_fsm_tb;
    logic clk, rst;

    logic vblank;//input
    logic [7:0] sprite_RAM_din;//input

    logic [7:0] ld_x,ld_y, ld_num_flips, ld_palette;

    logic rd_en;

    logic [7:0] fsm_dout;

    logic [31:0] palette_out;

    logic [15:0] sprite_RAM_addr;


    sprite_fsm dut(.*);
    
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
