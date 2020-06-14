`timescale 1ns/100ps
module dec_ctrl
#(
parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
parameter [8-1:0]  N_NUM = 255,
parameter [`R_BW - 1 :0]  R_NUM = 16,
parameter [`R_BW - 1 :0]  T_NUM = R_NUM/2
) 
(
input clk,
input rst_n,
input err_loc_val_sync,

output reg             fifo_rd,

input  [SYM_BW-1:0]    fifo_out,

output reg [SYM_BW-1:0]     symbol_cnt,
output reg [SYM_BW-1:0]     symbol_out

);

reg [7:0] byte_cnt1;
reg [7:0] byte_cnt2;
reg [7:0] byte_cnt3;


always @(posedge clk or negedge rst_n)
if (!rst_n)
  byte_cnt1 <= 0;
else if (err_loc_val_sync)
  byte_cnt1 <= 1;
else if ((byte_cnt1 < N_NUM ) && byte_cnt1)
  byte_cnt1 <= byte_cnt1 + 1;
else 
  byte_cnt1 <= 0;
  
always @(posedge clk or negedge rst_n)
if (!rst_n)
  fifo_rd <= 0;
else if (byte_cnt1 >= 8'd1 && byte_cnt1 <= N_NUM )
  fifo_rd <= 1;  
else    
  fifo_rd <= 0;
  
always @(posedge clk or negedge rst_n)
if (!rst_n) begin
  byte_cnt2  <= 0;
  byte_cnt3  <= 0;
  symbol_cnt <= 0;
end else begin
  byte_cnt2  <= byte_cnt1;
  byte_cnt3  <= byte_cnt2;
  symbol_cnt <= byte_cnt3;
end

always @(posedge clk or negedge rst_n)
if (!rst_n) begin
  symbol_out  <= 0;

end else begin
  symbol_out  <= fifo_out;

end
       
       
       
endmodule       