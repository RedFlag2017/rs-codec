module fifo_buffer #(
parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
parameter DEPTH = 1024
)(
input         clk     ,
input         rst     ,
input         rd      ,
input         wr     ,
input [SYM_BW-1:0]   datain   ,
output reg [SYM_BW-1:0]  dataout  ,
output        empty,
output        full

);


// parameter DEPTH = 1024;


// reg [7:0] dataout;
reg [9:0] read_ptr,write_ptr,counter;
reg [SYM_BW-1:0] ram [DEPTH - 1:0];
// wire empty,full;

always @(posedge clk)
 if(rst)
  begin
  read_ptr <= 0;
  write_ptr <= 0;
  counter <= 0;
  dataout <= 0;
  end
 else
 case({rd,wr})
  2'b00: counter <= counter;
  2'b01: begin
     ram[write_ptr] <= datain;
     counter <= counter+1;
     write_ptr <= (write_ptr== DEPTH-1)?0:write_ptr+1;
     end
  2'b10: begin
     dataout <= ram[read_ptr];
     counter <= counter-1;
     read_ptr <= (read_ptr== DEPTH-1)?0:read_ptr+1;
     end
  2'b11: begin
     if(counter==0)
      dataout <= datain;
     else
      begin
       ram[write_ptr] <= datain;
       dataout <= ram[read_ptr];
       write_ptr <= (write_ptr==DEPTH-1)?0:write_ptr+1;
       read_ptr <= (read_ptr==DEPTH-1)?0:read_ptr+1;
      end
     end
 endcase
assign empty=(counter==0);
assign full=(counter==DEPTH-1);

endmodule