/* Memory management for TV80 CPU and GPU coordination
 * Not portable at all. Don't use under other circumstances!
 */

/*
  0      - 0x3FFF -- code(ROM) 
  0x4000 - 0x47FF -- Frame buffer
  0x4800 - 0x50ff -- RAM 
  
  arbitration policy: 
  GPU will take precedence since CPU has a convenient signal
  cpu_wait_n that we can use. 

*/

module pacman_mm
(input logic clk, reset_n,
 input logic [15:0] cpu_addr_in, 
 //input logic [7:0] cpu_data_in, 
 input logic cpu_mreq_n, 
 input logic [15:0] gpu_addr_in1,
 input logic [15:0] gpu_addr_in2,
 
 output logic [13:0] rom_addra, 
 output logic rom_ena, 
 output logic [11:0] ram_addra, 
 output logic ram_ena, 

 output logic [10:0] fb_addra, 
 output logic [10:0] fb_addrb,
 output logic fb_ena, 
 output logic fb_enb, 

 // signals for the top module
 output logic rom_di_valid, 
 output logic ram_di_valid,  
 output logic cpu_wait_n,
 output logic conflict);
// output logic [7:0] data_out) 
// TODO do we need those?
// output logic [7:0] cpu_data_out1, // for ROM
// output logic [7:0] cpu_data_out2) // for normal RAM access
  
  enum logic [3:0] {IDLE, CPU_ROM_ACK, CPU_RAM_ACK1, CPU_RAM_ACK2, CPU_FB_ACK} state, next; 
  logic rom_access, gpu_rd; 
  
  always_ff @(posedge clk, negedge reset_n) begin
    if (~reset_n) 
      state <= IDLE; 
    else begin 
      state <= next; 
    end
  end
  

  assign conflict = (fb_access && gpu_rd) && (~cpu_mreq_n); 
  assign rom_access = (cpu_addr_in <= 16'h3fff);
  assign gpu_rd = (gpu_addr_in1 != 0);
  assign fb_access = (cpu_addr_in <= 16'h47ff) && (cpu_addr_in >= 16'h4000);

  always_comb begin 
    rom_addra = 0; 
    ram_addra = 0; 
    rom_ena = 0;
    ram_ena = 0;
    cpu_wait_n = 0; // for high
    fb_ena = 0; 
    fb_enb = 0;
    fb_addra = 0; 
    fb_addrb = 0;
    rom_di_valid = 0;
    ram_di_valid = 0;
    case (state) 
      IDLE: begin
        // since GPU is constantly running, no need for another state
        if (gpu_rd) begin
          // 47ff == 100 0111 1111 1111
          fb_ena = 1; 
          fb_enb = 1;
          fb_addra = gpu_addr_in1[10:0]; 
          fb_addrb = gpu_addr_in2[10:0];
        end
        
        // handle the CPU requests
        if (~cpu_mreq_n & ~conflict) begin
          if (rom_access) begin
            rom_ena = 1; 
            rom_addra = cpu_addr_in[13:0]; 
            next = CPU_ROM_ACK; 
          end
          else if (fb_access) begin
            // for a fb access (with no conflict)
            fb_addra = cpu_addr_in[10:0]; 
            fb_ena = 1;
            next = CPU_FB_ACK; 
          end
          else begin
            // a normal RAM access
            // 4800 == 100 1000 0000 0000
            // 50ff == 101 0000 1111 1111
            // 900  ==     1001 0000 0000
            ram_ena = 1; 
            ram_addra = (cpu_addr_in - 16'h4800); 
            next = CPU_RAM_ACK1;
          end
        end
        else if (conflict) begin
          // got a conflicting access -- halt the CPU and wait for GPU to finish -- BAD approach but can't stop this.. 
          next = IDLE; 
        end 
        else begin
          // no read
          next = IDLE; 
          cpu_wait_n = 1;
//          if (rom_access) begin
//            rom_ena = 1; 
//            rom_addra = cpu_addr_in[13:0]; 
//            next = CPU_ROM_ACK; 
//          end
        end
      end
      CPU_FB_ACK: begin
        cpu_wait_n = 1;
        fb_addra = cpu_addr_in[10:0]; 
        fb_ena = 1;
        next = IDLE; 
      end
      CPU_ROM_ACK: begin
        cpu_wait_n = 1; 
        rom_di_valid = 1;
        rom_ena = 1; 
        rom_addra = cpu_addr_in[13:0]; 
        if (~cpu_mreq_n) begin
            next = CPU_ROM_ACK;
        end
        else begin
            next = IDLE;
        end 
      end
      CPU_RAM_ACK1: begin
        ram_ena = 1; 
        ram_addra = (cpu_addr_in - 16'h4800); 
        next = CPU_RAM_ACK2;
      end
      CPU_RAM_ACK2: begin
        cpu_wait_n = 1;
        ram_di_valid = 1;
        ram_ena = 1; 
        ram_addra = (cpu_addr_in - 16'h4800); 
        if (~cpu_mreq_n) begin
            next = CPU_RAM_ACK2;
        end
        else begin
            next = IDLE;
        end 
      end
    endcase
  end
  

endmodule





