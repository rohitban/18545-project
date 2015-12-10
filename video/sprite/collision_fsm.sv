`define TILEMAP_OFFSET 16'h4000
`define CPU_OFFSET 16'h42E
//Ghost sprites are 8-15 and  28-31 and 32-39 and 50-51
//pacman sprites are 44-48 and 52-63

//4c32 - 4c3f
module cpu_ram_mapper
    (input  logic [2:0] update_index,
     output logic [15:0] x_addr, y_addr,
     output logic [15:0] cpu_x_addr, cpu_y_addr);

    assign y_addr = x_addr + 'h1;

    assign cpu_x_addr = x_addr - `CPU_OFFSET;

    assign cpu_y_addr = cpu_x_addr + 'h1;

    always_comb
        case(update_index)
            'd0: x_addr = 'h5060;
            'd1: x_addr = 'h5062;
            'd2: x_addr = 'h5064;
            'd3: x_addr = 'h5066;
            'd4: x_addr = 'h5068;
            'd5: x_addr = 'h506a;
            'd6: x_addr = 'h506c;
            'd7: x_addr = 'h506e;
        endcase

endmodule: cpu_ram_mapper


module collision_fsm
    (input  logic clk, rst,
     input  logic [2:0] update_index,//index of sprite 
     //begin updated

     input  logic [7:0] tile_ROM_addr,

     input  logic [5:0] sprite_num,

     //POSITIONS
     input  logic [7:0][7:0] sprite_x, sprite_y,  


     //Sprite update should be asserted
     //by mem remap 
     input  logic       sprite_update,
     output  logic [7:0] restore,    

     input  logic [7:0] sprite_row, sprite_col,

     output logic        wr_en,
     output logic [7:0]  write_val,

     output logic       cpu_pause,
     output logic [15:0] tile_ram_addr);
    
    logic start_fsm;

    
    logic is_wall, is_pill;//checks for tiles

    /////////////////////TILE CHECK////////////////////////////

    assign is_pill = 'd 16 <= tile_ROM_addr && tile_ROM_addr < 'd19; 

    assign is_wall = 'd222 <= tile_ROM_addr && tile_ROM_addr < 'd252;
    
    logic is_pacman, is_ghost;//checks for sprites

    ////////////////////SPRITE CHECK//////////////////////////

    //Ghost sprites are 8-15 and  28-31 and 32-39 and 50-51

    assign is_ghost = ('d8 <= sprite_num && sprite_num < 'd16)||
                      ('d28 <= sprite_num && sprite_num < 'd32)||
                      (sprite_num == 'd50) || (sprite_num == 'd51);
    
    //pacman sprites are 44-48 and 52-63
    assign is_pacman = ('d44 <= sprite_num && sprite_num <= 'd63)&&~is_ghost;

    ////////////////////////////////////////////////////////////// 
    
    assign start_fsm = (is_pacman||is_ghost)&&sprite_update;

    //check for walls/pills
    logic [8:0] next_tile_row;
    logic [9:0] next_tile_col;

    logic [15:0] calc_tile_addr;

    assign next_tile_row = {1'b0,sprite_row} + 'd4;
    assign next_tile_col = {2'b0,sprite_col} + 'd4;

    tilemap_addr_dcd dcd(.row(next_tile_row),
                         .col(next_tile_col),
                         .raw_addr(calc_tile_addr));

    enum {IDLE,RAM_WAIT,PROCESS,WALL,WALL_X_HW,WALL_X_SW,WALL_Y_HW} cs, ns;

    //Check which addresses to update
    logic [15:0] x_addr, y_addr, cpu_x_addr, cpu_y_addr;
    
    cpu_ram_mapper cpu_map(.update_index,
                           .x_addr,
                           .y_addr,
                           .cpu_x_addr,
                           .cpu_y_addr);
                            

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
        restore = 0;

        //To write to RAM
        wr_en = 0;
        write_val = 0;

        case(cs)
            IDLE: begin
                ns = (start_fsm)?RAM_WAIT:IDLE;
                cpu_pause = (start_fsm)?1'b1:1'b0;
            end
            RAM_WAIT: begin
                cpu_pause = 1;
                tile_ram_addr = calc_tile_addr + `TILEMAP_OFFSET;
                ns = PROCESS;
            end
            
            //This state still needs new control signals
            PROCESS: begin
                cpu_pause = 1;
                if(is_wall&(is_pacman||is_ghost)) begin
                    restore[update_index] = 1'b1;
                    ns = WALL;//do not do the update
                end
                else if(is_pacman&is_pill) begin
                  tile_ram_addr = calc_tile_addr+ `TILEMAP_OFFSET;
                  wr_en = 1;
                  write_val = 'd255;
                  ns = IDLE;//process eating a pill
                end
                else
                  ns = IDLE;
            end
            WALL: begin
                cpu_pause = 1;
                ns = WALL_X_HW;
                tile_ram_addr = x_addr;
                write_val = sprite_x;
                wr_en = 1;
            end
            WALL_X_HW: begin
                cpu_pause = 1;
                ns = WALL_Y_HW;
                tile_ram_addr = y_addr;
                write_val = sprite_y;
                wr_en = 1;
            end

            WALL_Y_HW: begin
                cpu_pause = 1;
                ns = WALL_X_SW;
                tile_ram_addr = cpu_x_addr;
                write_val = sprite_x;
                wr_en = 1;
            end

            WALL_X_SW: begin
                cpu_pause = 1;
                ns = IDLE;
                tile_ram_addr = cpu_y_addr;
                write_val = sprite_y;
                wr_en = 1;
            end
            
        endcase        
    end
endmodule: collision_fsm
