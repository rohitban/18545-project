// top module for CPU + RAM + GPU system
// provides interface for VGA and the sound system


module tb;
    logic clk, btnC, reset_n;
    logic Hsync, Vsync;
    logic [3:0] vgaRed, vgaGreen, vgaBlue;
    logic [7:0] cpu_di_probe; 
    logic [15:0] cpu_addr_probe;
    logic micClk, micLRSel, micData;
    
    initial begin
      clk = 0;
      btnC = 1;
      forever #5 clk = ~clk; 
    end
    
    top t(.*);
    
    initial begin  
      @(posedge clk);
      btnC = 0;
         
      for(int i = 0; i<1000; i++) begin
        @(posedge clk);
//        @(posedge clk);
//        @(posedge clk);
//        @(posedge clk);
      end
     
      $finish;
    end
endmodule

module top
  (input logic clk,btnC,
//   // use switches for system on/off
//   input logic 
//   input logic
//   // joystick controller vs. voice control? 
//   input logic
//   output logic [7:0] cpu_di_probe, 
//   output logic [15:0] cpu_addr_probe, 

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
  logic         conflict;
 
  // RAM interconnects 
  logic [11:0]  ram_addra;
  logic [7:0]   ram_dina, ram_douta;
  logic         ram_ena;    /* ram port A enable */
  logic         ram_wea;    /* ram write enable */
 
  // ROM interconnects
  logic [13:0]  rom_addra; 
  logic [7:0]   rom_douta; 
  logic         rom_ena;    /* ram port A enable */
  
  logic         rom_di_valid, ram_di_valid; /* for CPU_DI de-multiplexing */
  
   // CPU connections
   // Outputs 
   logic cpu_m1_n;       /* machine cycle one */
   /* logic mreq -- memory request? */
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

    
   // GPU connections
   logic [7:0] tile_ROM_addr;
   logic [5:0] palette_ROM_addr;
   
   logic [15:0] tile_RAM_addr;
   logic [15:0] palette_RAM_addr;
       
  
  /**************************************************************
   *              Hacks                                         *
   *                              begin                         *
   **************************************************************/ 
 
  /**************************************************************
   *              Hacks                                         *
   *                              end                           *
   **************************************************************/
  
  
  
  /**************************************************************
   *              Interconnect                                  *
   *                              begin                         *
   **************************************************************/
   
    assign cpu_int_n = 1; 
    assign cpu_nmi_n = 1; 
    assign cpu_busrq_n = 1; 
    
    // all data connections
    assign fb_dina = cpu_dout;
    assign ram_dina = cpu_dout;
    assign tile_ROM_addr = fb_douta;
    assign palette_ROM_addr = fb_doutb;
    
    // TODO ==> need to multiplex with cpu_di <== maybe use the module below
    always_comb begin
      cpu_di = 0;
      if (rom_di_valid) begin
        cpu_di = rom_douta;
      end 
      else begin
        cpu_di = ram_douta;
      end
    end
    
    // all write enables are from the CPU
    assign fb_wea = (~cpu_wr_n) && (~cpu_mreq_n) && (~conflict);
    assign ram_wea = (~cpu_wr_n) && (~cpu_mreq_n);
    
    // The major arbitration module that handles routing
    pacman_mm mm(.cpu_addr_in(cpu_A), .gpu_addr_in1(tile_RAM_addr), 
                 .gpu_addr_in2(palette_RAM_addr), .*);
    
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
                 
                 .Hsync,
                 .Vsync);
   

   

   
  /**************************************************************
   *              GPU                                           *
   *                              end                           *
   **************************************************************/
  
  /**************************************************************
   *              MM(memory management)                         *
   *                              begin                         *
   **************************************************************/
    
     
   
     
  /**************************************************************
   *              MM                                            *
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
                       .addra(ram_addra), .clka(clk), .dina(ram_dina), 
                       .ena(ram_ena), .wea(ram_wea)); 

  /**************************************************************
   *              RAM                                           *
   *                              end                           *
   **************************************************************/
    //ila_0 ila(.clk(clk),.probe0(cpu_wr_n), .probe1(cpu_mreq_n));

endmodule




