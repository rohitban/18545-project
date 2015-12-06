// top module for CPU + RAM + GPU system
// provides interface for VGA and the sound system


module tb;
    logic clk, btnC, reset_n;
    logic Hsync, Vsync;
    logic [3:0] vgaRed, vgaGreen, vgaBlue;
    logic [7:0] cpu_di_probe; 
    logic [15:0] cpu_addr_probe, sw;
    logic micClk, micLRSel, micData;
    
    logic ampPWM, ampSD;
    
    initial begin
      clk = 0;
      btnC = 1;
      forever #5 clk = ~clk; 
    end
    
    top t(.*);
    
    initial begin  
      @(posedge clk);
      btnC = 0;
      sw = 16'b0000_0000_0000_1100;;
      @(posedge clk);  
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);      
      
      for(int i = 0; i<1000; i++) begin
        sw = 16'h0001;
        @(posedge clk);
        sw = 16'h0002;
        @(posedge clk);
        sw = 16'h0003;
        @(posedge clk);
        sw = 16'h0000;
        @(posedge clk);
      end
   end
endmodule

module top
  (input logic clk,btnC,
//   // use switches for system on/off
   input logic [15:0] sw,
//   input logic
//   // joystick controller vs. voice control? 
//   input logic
//   output logic [7:0] cpu_di_probe, 
//   output logic [15:0] cpu_addr_probe,
 
   //Sound output
   output logic ampPWM,
   output logic ampSD,

   // VGA output
   output logic       Hsync,
   output logic       Vsync,
   output logic [3:0] vgaRed, vgaGreen, vgaBlue,
   // Microphone input/output
   output logic     micClk, 
   output logic     micLRSel, 
   input logic      micData);
//   // sound output
//   output logic
//   output logic
//   output logic
//   output logic); 
  
  
  // generic signals
  //logic reset_n;
  
  assign reset_n = ~btnC;
    
  // FB interconnects 
  logic [10:0]  fb_addra, fb_addrb;
  logic [7:0]   fb_dina, fb_dinb, fb_doutb, fb_douta;
  logic         fb_ena;    /* ram port A enable */
  logic         fb_enb;    /* ram port B enable */
  logic         fb_wea;    /* ram write enable */
  logic         fb_web;
  logic         gpu_rd;
 
  // RAM interconnects 
  logic [11:0]  ram_addra, ram_addra_final, ram_addr_setup;
  logic [7:0]   ram_dina, ram_dina_final, ram_din_setup;
  logic [7:0]   ram_douta;
  logic         ram_ena, ram_ena_final, ram_en_setup;    /* ram port A enable */
  logic         ram_wea, ram_wea_final, ram_we_setup;    /* ram write enable */
  logic         ram_disable; // disable RAM for special writes e.g. 5000, 5040
 
  // ROM interconnects
  logic [13:0]  rom_addra; 
  logic [7:0]   rom_douta; 
  logic         rom_ena;    /* ram port A enable */
  
  logic         rom_di_valid, ram_di_valid; /* for CPU_DI de-multiplexing */
  
   // CPU connections
   // Outputs 
   logic cpu_m1_n;       /* machine cycle one */
   logic cpu_mreq_n; 
   logic cpu_iorq_n;     /* IO request -- lower half of A is valid */
   logic cpu_rd_n; 
   logic cpu_wr_n; 
   logic cpu_rfsh_n;     /* lower 7b of A can be refreshed */
   logic cpu_halt_n;     /* machine is halted */
   logic cpu_busak_n;    /* bus ack -- let device control */
   logic [15:0] cpu_A;   /* 16b address bus */
   logic [7:0] cpu_dout; /* data out */
   // Inputs
   logic cpu_wait_n;     /* memory is not ready */
   logic cpu_int_n;      /* interrupt */
   logic cpu_nmi_n;      /* nonmaskable interrupt */
   logic cpu_busrq_n;    /* bus request -- device ask for control */
   logic [7:0] cpu_di;   /* data in */

   logic cpu_wait_mm;
    
   // GPU connections
   logic [7:0] tile_ROM_addr;
   logic [5:0] palette_ROM_addr;
   
   logic [15:0] tile_RAM_addr;
   logic [15:0] palette_RAM_addr;
   
   // controls
   logic [1:0]  move, move_latch;
   logic [3:0]  move_bit; 
   logic        move_change;  
       
  
  /**************************************************************
   *              Hacks                                         *
   *                              begin                         *
   **************************************************************/ 
   // clear all inputs before the game starts  
   logic ready; // could possibly be use in other places for memory init
   // just wait for 100 cycles before starting
   logic [6:0] ready_cnt, change_cnt;
   always_ff @(posedge clk, negedge reset_n) begin
     if (~reset_n) begin 
       ready_cnt <= 0;
       ready <= 0;
       change_cnt <= 0; 
     end
     else begin
       if (ready_cnt == 7'd100) begin
            if (change_cnt <= 7'd20) begin
                ready <= 0; 
                change_cnt <= change_cnt + 1;
            end
            else begin
                ready <= 1;
            end
       end
       else begin
         ready_cnt <= ready_cnt + 1;
       end
       
       if (move_change) begin
            change_cnt <= 0;
       end
       

     end
   end   
   
   // preset some RAM values
   always_comb begin
     if (~ready) begin
        ram_addr_setup = 0;
        ram_en_setup = 0; 
        ram_we_setup = 0; 
        ram_din_setup = 0;
        case (ready_cnt)
            7'd10: begin
                // clear input0 location
                ram_addr_setup = 13'h800; // 0x5000 - 0x4800
                ram_en_setup = 1; 
                ram_we_setup = 1; 
                ram_din_setup = 8'b1001_1111;
            end
            7'd20: begin
                // clear input0 location
                ram_addr_setup = 13'h840;
                ram_en_setup = 1; 
                ram_we_setup = 1; 
                ram_din_setup = 8'b1111_1111;
            end
            7'd30: begin
                // set mode == 3 -> one player
                ram_addr_setup = 13'h600;
                ram_en_setup = 1; 
                ram_we_setup = 1; 
                ram_din_setup = {6'd0, sw[3:2]};
            end
            7'd40: begin
                // set credit == 0x99
                ram_addr_setup = 13'h66e;
                ram_en_setup = 1; 
                ram_we_setup = 1; 
                ram_din_setup = 8'd99;
            end
            // possibly use switch to select modes
        endcase
        
        case(change_cnt)
            7'd5: begin
                ram_addr_setup = 13'h800; // 0x5000 - 0x4800
                ram_en_setup = 1; 
                ram_we_setup = 1; 
                ram_din_setup = {4'b1001, move_bit};
            end
            7'd10: begin
                 ram_addr_setup = 13'h840; // 0x5000 - 0x4800
                 ram_en_setup = 1; 
                 ram_we_setup = 1; 
                 ram_din_setup = {4'b1001, move_bit};
             end
        endcase
     end
   end
   
   
   // hardcode the timer interrupt This runs the game
   // we are running at 50MHz -> 10ms timer interrupt = 500,000 cycles
   // log(2)(500,000) = 18.9 
   logic [17:0] int_cnt;
   logic int_e, int_e_new; // if interrupt is disabled by writes to 0x5000
   always_ff @(posedge clk, negedge reset_n) begin
      if (~reset_n) begin 
        int_cnt <= 0;
        cpu_int_n <= 1;
        int_e <= 0;
      end
      else begin
        int_e <= int_e_new;
        if (int_cnt == 18'd100000) begin
          if (int_e) begin
            cpu_int_n <= 0;
          end
          int_cnt <= 0;
        end
        else begin
          int_cnt <= int_cnt + 1;
          cpu_int_n <= 1;
        end
      end
   end
   
   // parse memory writes to 0x5000 to generate interrupt enable/disable signals
   always_comb begin
     int_e_new = int_e;
     ram_disable = 0;
     if ((cpu_A == 16'h5000) & ram_ena & ram_wea) begin
        int_e_new = cpu_dout[0];
        ram_disable = 1;
     end
   end
   
   
   // for debug
   logic _task_list_wr, _input_rd, _jump_table_active; 
   assign _task_list_wr = (cpu_A >= 16'h4cc0 && cpu_A <= 16'h4cff) & ram_ena & ram_wea;
   assign _input_rd = (cpu_A == 16'h5000) & ram_ena & (~ram_wea);
   
   logic _tile_pallete_wr, _ghost_pallete_wr, _sprite_pallete_wr, _ghost_pallete_rd, _sprite_pallete_rd; 
   assign _tile_pallete_wr = (cpu_A <= 16'h47ff && cpu_A >= 16'h4400) & fb_ena & fb_wea;
   assign _ghost_pallete_wr = (cpu_A == 16'h4c03 || cpu_A == 16'h4c05 || cpu_A == 16'h4c07 || cpu_A == 16'h4c09 || cpu_A == 16'h4c0b) & ram_ena & ram_wea;
   assign _sprite_pallete_wr = (cpu_A == 16'h4ff1 || cpu_A == 16'h4ff3 || cpu_A == 16'h4ff5 || cpu_A == 16'h4ff9 || cpu_A == 16'h4ffb || cpu_A == 16'h4ffd || cpu_A == 16'h4fff) & ram_ena & ram_wea;
   assign _ghost_pallete_rd = (cpu_A == 16'h4c03 || cpu_A == 16'h4c05 || cpu_A == 16'h4c07 || cpu_A == 16'h4c09 || cpu_A == 16'h4c0b) & ram_ena & ~ram_wea;
   assign _sprite_pallete_rd = (cpu_A == 16'h4ff1 || cpu_A == 16'h4ff3 || cpu_A == 16'h4ff5 || cpu_A == 16'h4ff9 || cpu_A == 16'h4ffb || cpu_A == 16'h4ffd || cpu_A == 16'h4fff) & ram_ena & ~ram_wea;
//   assign _jump_table_active = (cpu_A == 16'h23ed || cpu_A == 16'h24d7 || cpu_A == 16'h2419 || cpu_A == 16'h2448 || cpu_A == 16'h253d || cpu_A == 16'h268b || cpu_A == 16'h240d || cpu_A == 16'h2698 || cpu_A == 16'h2730 || cpu_A == 16'h276c);
   assign _jump_table_active = (cpu_A == 16'h2698);
  /**************************************************************
   *              Hacks                                         *
   *                              end                           *
   **************************************************************/
  
  
  
  /**************************************************************
   *              Interconnect                                  *
   *                              begin                         *
   **************************************************************/
   
    assign cpu_nmi_n = 1; 
    assign cpu_busrq_n = 1; 
    
    // all data connections
    assign fb_dina = cpu_dout;
    assign ram_dina = cpu_dout;
    assign tile_ROM_addr = fb_douta;
    assign palette_ROM_addr = fb_doutb;
//    assign palette_ROM_addr = 1;
    
    
    always_comb begin
      cpu_di = 0;
      if (rom_di_valid) begin
        cpu_di = rom_douta;
      end 
      else begin
        if (ram_di_valid) begin
          cpu_di = ram_douta;
        end
      end
    end
    
    // all write enables are from the CPU
    assign fb_wea  = (~cpu_wr_n) && (~cpu_mreq_n) && (~gpu_rd);
    assign ram_wea = (~cpu_wr_n) && (~cpu_mreq_n);
    
    assign ram_addra_final = ready ? ram_addra : ram_addr_setup; 
    assign ram_dina_final  = ready ? ram_dina  : ram_din_setup;
    assign ram_wea_final   = ready ? ram_wea   : ram_we_setup;
    assign ram_ena_final   = ready ? (ram_ena & ~ram_disable)   : ram_en_setup;
    
    assign cpu_wait_n = cpu_wait_mm & ready; 
    // The major arbitration module that handles routing
    pacman_mm mm(.cpu_addr_in(cpu_A), .gpu_addr_in1(tile_RAM_addr), 
                 .gpu_addr_in2(palette_RAM_addr), .cpu_wait_n(cpu_wait_mm), .*);
    
  /**************************************************************
   *              Interconnect                                  *
   *                              end                           *
   **************************************************************/

  /**************************************************************
   *              Z80 CPU                                       *
   *                              begin                         *
   **************************************************************/
 
  tv80s cpu     ( // outputs 
                .m1_n(cpu_m1_n), .mreq_n(cpu_mreq_n), .iorq_n(cpu_iorq_n), .rd_n(cpu_rd_n), 
                .wr_n(cpu_wr_n), .rfsh_n(cpu_rfsh_n), .halt_n(cpu_halt_n), 
                .busak_n(cpu_busak_n), .A(cpu_A), .dout(cpu_dout), 
                // inputs 
                .wait_n(cpu_wait_n), .int_n(cpu_int_n), .nmi_n(cpu_nmi_n), 
                .busrq_n(cpu_busrq_n), .di(cpu_di), .*);

  /**************************************************************
   *              Z80 CPU                                       *
   *                              end                           *
   **************************************************************/

  

    
  
  
  
  /**************************************************************
   *              GPU                                           *
   *                              begin                         *
   **************************************************************/

   
   //should only display tiles atm
   video_top gpu(.clk,
                 .rst(~reset_n),//needs reset input
                 
                 //output RAM addresses
                 .tile_RAM_addr,
                 .palette_RAM_addr,
                 
                 //input ROM_addresses
                 .tile_ROM_addr,
                 .palette_ROM_addr,
                 
                 //vga signals need to be output 
                 .vgaRed,
                 .vgaBlue,
                 .vgaGreen,
                 
                 .sprite_RAM_din(ram_dina_final),//ram_dina),
                 .wr_en(ram_wea_final),//ram_wea),
                 .RAM_addr(cpu_A),
                 
                 .Hsync,
                 .Vsync);
   

   

   
  /**************************************************************
   *              GPU                                           *
   *                              end                           *
   **************************************************************/
   
   /**************************************************************
    *              SOUND                                         *
    *                              begin                         *
    **************************************************************/
   
   sound_top sound(.clk, 
                   .rst(~reset_n),
                   
                   //Memory inputs
                   .wr_en(ram_wea_final),
                   .cpu_data(ram_dina_final),
                   .ram_addr(cpu_A),
                   
                     //Sound output
                    .ampPWM, 
                    .ampSD);
   
   
   /**************************************************************
    *              SOUND                                         *
    *                              end                           *
    **************************************************************/
    
    
   /**************************************************************
    *              CONTROL                                       *
    *                              begin                         *
    **************************************************************/
    always_ff @(posedge clk, negedge reset_n) begin
       if (~reset_n) begin 
            move_latch <= 0; 
       end
       else begin
            move_latch <= #1 move; 
       end
    end
    assign move = sw[1:0]; 
    assign move_change = (move != move_latch); 
    always_comb begin
        case (move) 
            2'b00: begin 
                move_bit = 4'b1110;
            end
            2'b01: begin 
                move_bit = 4'b1101;
            end            
            2'b10: begin 
                move_bit = 4'b1011;
            end
            2'b11: begin 
                move_bit = 4'b0111;
            end
        endcase                      
    end
    
   /**************************************************************
    *              CONTROL                                       *
    *                              end                           *
    **************************************************************/
  
  
  /**************************************************************
   *              ROM                                           *
   *                              begin                         *
   **************************************************************/
     blk_mem_gen_1 rom( //outputs
                        .douta(rom_douta), 
                        //inputs
                        .addra(rom_addra), .clka(clk), .ena(rom_ena)); 
  
  /**************************************************************
   *              ROM                                           *
   *                              end                           *
   **************************************************************/
  
  

  
  /**************************************************************
   *              RAM                                           *
   *                              begin                         *
   **************************************************************/
    
    assign fb_web = 0;
    assign fb_dinb = 0;
    blk_mem_gen_2 fb( //outputs
                       .douta(fb_douta),
                       .doutb(fb_doutb), 
                       //inputs
                       .addra(fb_addra), .clka(clk), .dina(fb_dina), 
                       .addrb(fb_addrb), .clkb(clk), .dinb(fb_dinb),
                       .enb(fb_enb), .web(fb_web),
                       .ena(fb_ena), .wea(fb_wea)); 

    blk_mem_gen_0 ram( //outputs
                       .douta(ram_douta), 
                       //inputs
                       .addra(ram_addra_final), .clka(clk), .dina(ram_dina_final), 
                       .ena(ram_ena_final), .wea(ram_wea_final)); 

  /**************************************************************
   *              RAM                                           *
   *                              end                           *
   **************************************************************/
    //ila_0 ila(.clk(clk),.probe0(cpu_wr_n), .probe1(cpu_mreq_n));

endmodule




