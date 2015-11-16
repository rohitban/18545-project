

module sprite_pix_test;
    logic [3:0] row, col;
    logic       xflip, yflip;

    logic [7:0] pixel_num;

    sprite_pixel_num dut(.*);

    initial begin
      $monitor($time," row=%d,col=%d,xflip=%b,yflip=%b,pixel_num=%d",
                       row,col,xflip,yflip,pixel_num);
      xflip = 1;
      yflip = 1;
      
      for(int i = 0;i<16;i++) begin
        for(int j=0;j<16;j++) begin
          row = i;
          col = j;
          #10;
        end
      end
      

      #10;
      $finish;
    end

endmodule: sprite_pix_test
