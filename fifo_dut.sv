module SYN_FIFO(clk, reset, i_wrdata, i_wren, i_rden, 0_full, o_empty, o_rddata);
 parameter DATA_W           = 128 ;       // Data width
                   parameter DEPTH            = 1024  ;       // Depth of FIFO                   
                   parameter UPP_TH           = 4   ;       // Upper threshold to generate Almost-full
                   parameter LOW_TH           = 2  ;
  
  input clk, reset, i_wren, i_rden;
  input [WIDTH-1:0] i_wrdata;
  output reg 0_full, o_empty;
  output reg [WIDTH-1:0] o_rddata;
  
  reg [ADDRESS-1:0] counter;
  reg [WIDTH-1:0] memory [DEPTH-1:0];
  //reg [ADDRESS-1:0] cur_ptr;
 
  assign o_full = (counter == 'b1111);
  assign o_empty = (counter == 'b0000);
  
  always@(posedge clk)begin
    if(reset == 1)begin
     
      o_rddata <= 'b0;
      foreach (memory[i,j])
        memory[i][j] <= 'b0;
    end
    else begin
      if(i_wren == 1 && o_full != 1)begin
        memory[counter] <= i_wrdata;
       counter <= counter+1;
      end
      if(i_rden == 1 && o_empty!= 1)begin
        o_rddata <= memory[counter];
        counter <= counter- 1;
      end
     // cur_ptr = wr_ptr - rd_ptr;
    end
  end
endmodule
