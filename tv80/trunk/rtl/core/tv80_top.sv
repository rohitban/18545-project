// top module for CPU + RAM + GPU system
// provides interface for VGA and the sound system


module top;
//  (input logic clock);
//   // use switches for system on/off
//   input logic 
//   input logic
//   // joystick controller vs. voice control? 
//   input logic
//   input logic
//   input logic
//   input logic

//   // VGA output
//   output logic
//   output logic
//   output logic
//   // sound output
//   output logic
//   output logic
//   output logic
//   output logic); 
  
  
  // generic signals
  logic reset_n; 
  logic clk;      
  
  // RAM interconnects 
  logic [11:0]  ram_addra, ram_addrb;
  logic [7:0]   ram_dina, ram_doutb;
  logic         ram_ena;    /* ram port A enable */
  logic         ram_enb;    /* ram port B enable */
  logic         ram_wea;    /* ram write enable */
 
  // ROM interconnects
  logic [13:0]  rom_addra; 
  logic [7:0]   rom_douta; 
  logic         rom_ena;    /* ram port A enable */
  
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
 
   
  
  /**************************************************************
   *              Hacks                                         *
   *                              begin                         *
   **************************************************************/
 //   assign reset_n = 1'b1; 
 
  /**************************************************************
   *              Hacks                                         *
   *                              end                           *
   **************************************************************/
  
  
  
  /**************************************************************
   *              Interconnect                                  *
   *                              begin                         *
   **************************************************************/
    
    // route reads and writes from CPU to RAM/ROM by using the last bit of the address bus
    logic rom_rd_en; 
    logic ram_rd_en; 
    logic ram_wr_en; 
    assign rom_rd_en = !cpu_mreq_n & !cpu_rd_n & !cpu_A[15];
    assign ram_rd_en = !cpu_mreq_n & !cpu_rd_n & cpu_A[15];
    assign ram_wr_en = !cpu_mreq_n & !cpu_wr_n & cpu_A[15];
    
    assign rom_ena = rom_rd_en; // maybe we want to always enable this port
    assign ram_ena = ram_wr_en;
    assign ram_enb = ram_rd_en; 
    assign ram_wea = ram_wr_en; // controls the ram write port
    
    // hook up the memory
    assign rom_addra = cpu_A[13:0];
    assign ram_addra = cpu_A[11:0];
    assign ram_addrb = cpu_A[11:0];
    assign ram_dina = ram_wr_en ? cpu_dout : 'bz; 

    assign cpu_di = rom_rd_en ? rom_douta : ram_doutb; 
    

  /**************************************************************
   *              Interconnect                                  *
   *                              end                           *
   **************************************************************/



  /**************************************************************
   *              Z80 CPU                                       *
   *                              begin                         *
   **************************************************************/
 
  tv80n cpu     ( // outputs 
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

  
   initial begin
      clk = 0;
      reset_n = 0;
      forever #5 clk = ~clk; 
    end
    
    initial begin
      $monitor($time, ": OUTPUTS: m1_n: %b, iorq_n: %b, rd_n: %b, wr_n: %b, rfsh_n: %b, halt_n: %b, busak_n: %b, A: %h, dout: %h, INPUTS: wait_n: %b, int_n: %b, nmi_n: %b, busrq_n: %b, di: %h",
      cpu_m1_n, cpu_iorq_n, cpu_rd_n, cpu_wr_n, cpu_rfsh_n, cpu_halt_n, cpu_busak_n,
      cpu_A, cpu_dout, cpu_wait_n, cpu_int_n, cpu_nmi_n, cpu_busrq_n, cpu_di);       
      
      @(posedge clk);
      reset_n = 1;  
      
      for(int i = 0; i<100; i++) begin
      @(posedge clk);
      cpu_wait_n = 0; // make cpu wait for 2 cycles
      cpu_int_n = 1; 
      cpu_nmi_n = 1; 
      cpu_busrq_n = 1; 
      @(posedge clk);
      cpu_wait_n = 1;
      @(posedge clk);
      cpu_wait_n = 0;
      end
     
      $finish;
    end
    
  
  
  
  /**************************************************************
   *              GPU                                           *
   *                              begin                         *
   **************************************************************/


  /**************************************************************
   *              GPU                                           *
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
    blk_mem_gen_0 ram( //outputs
                       .doutb(ram_doutb), 
                       //inputs
                       .addra(ram_addra), .clka(clk), .dina(ram_dina), 
                       .addrb(ram_addrb), .clkb(clk), .enb(ram_enb), 
                       .ena(ram_ena), .wea(ram_wea)); 

  /**************************************************************
   *              RAM                                           *
   *                              end                           *
   **************************************************************/


endmodule




