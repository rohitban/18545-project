// Testbench for the TV80 chip 
// Implementing Z80 for pacman

module tb; 

  // Outputs 
  logic m1_n;       /* machine cycle one */
  /* logic mreq -- memory request? */
  logic iorq;       /* IO request -- lower half of A is valid */
  logic no_read;    
  logic write;      /* data bus is valid to write */
  logic rfsh_n;     /* lower 7b of A can be refreshed */
  logic halt_n;     /* machine is halted */
  logic busak_n;    /* bus ack -- let device control */
  logic [15:0] A;   /* 16b address bus */
  logic [7:0] dout; /* data out */
  logic [6:0] mc; 
  logic [6:0] ts; 
  logic intcycle_n; /* ? current interrupt cycle */
  logic IntE;       /* ? interrupt enabled */ 
  logic stop;       

  // Inputs
  logic reset_n; 
  logic clk;      
  
  logic cen;        
  logic wait_n;     /* memory is not ready */
  logic int_n;      /* interrupt */
  logic nmi_n;      /* nonmaskable interrupt */
  logic busrq_n;    /* bus request -- device ask for control */
  logic [7:0] dinst;/* data instruction */
  logic [7:0] di;   /* data in */

  initial begin
    clk = 0;
    reset_n = 0;
    forever #5 clk = ~clk; 
  end

  tv80_core test(.*); 
  
  initial begin
    $monitor($time, ": m1_n: %b, iorq: %b, no_read: %b, write: %b, rfsh_n: %b, halt_n: %b, busak_n: %b, A: %d, dout: %d, mc: %d, ts: %d, intcycle_n: %b, IntE: %b, stop: %b",
    m1_n, iorq, no_read, write, rfsh_n, halt_n, busak_n, 
    A, dout, mc, ts, intcycle_n, IntE, stop);       
    #10;
    reset_n = 1; 
    #10;
    $finish;
  end
  
endmodule
