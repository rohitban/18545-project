`define TILEMAP_OFFSET 16'h4000
//Ghost sprites are 8-15 and  28-31 and 32-39 and 50-51
//pacman sprites are 44-48 and 52-63


module collision_fsm
    (input  logic clk, rst,
     input  logic [2:0] update_index,//index of sprite 
     //begin updated

     input  logic [7:0] tile_ROM_addr,

     input  logic [5:0] sprite_num,

     //Sprite update should be asserted
     //by mem remap 
     input  logic       sprite_update,
    

     input  logic [7:0] sprite_row, sprite_col,

     output logic       cpu_pause,
     output logic [15:0] tile_RAM_addr);

    logic is_wall, is_pill;//checks for tiles
    

    logic is_pacman, is_ghost;//checks for sprites

    logic [8:0] next_tile_row;
    logic [9:0] next_tile_col;

    logic [15:0] calc_tile_addr;

    assign next_tile_row = {1'b0,sprite_row} + 'd8;
    assign next_tile_col = {2'b0,sprite_col} + 'd16;

    tilemap_addr_dcd dcd(.row(next_tile_row),
                         .col(next_tile_col),
                         .raw_addr(calc_tile_addr));

    enum {IDLE,RAM_WAIT,PROCESS,WALL,PILL} cs, ns;

    always_ff@(posedge clk, posedge rst)
        if(rst)
          cs <= IDLE;
        else
          cs <= ns;

    
    always_comb begin
        //set all outputs to 0
        //some outputs still pending
        cpu_pause = 0;
        tile_ram_addr = 0;
        case(cs)
            IDLE: begin
                ns = (sprite_update)?RAM_WAIT:IDLE;
                cpu_pause = (sprite_update)?1'b1:1'b0;
            end
            RAM_WAIT: begin
                tile_ram_addr = calc_tile_addr + `TILEMAP_OFFSET;
                ns = PROCESS;
            end
            
            //This state still needs new control signals
            PROCESS: begin
                if(is_wall&(is_pacman||is_ghost)) begin
                    ns = WALL;//do not do the update
                end
                else if(is_pacman&is_pill) begin
                  ns = PILL;//process eating a pill
                end
                else begin
                  ns = IDLE;//no need to undo move
                end
            end
        endcase        
    end
endmodule: collision_fsm
