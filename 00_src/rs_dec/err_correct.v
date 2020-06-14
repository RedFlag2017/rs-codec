`timescale 1ns/100ps
module err_correct
#(
parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
parameter [8-1:0]  N_NUM = 255,
parameter [`R_BW - 1 :0]  R_NUM = 16,
parameter [`R_BW - 1 :0]  T_NUM = R_NUM/2
) 
(
input clk                        ,
input rst_n                      ,
input start                      ,
// input [3:0] error_num            ,

input [SYM_BW-1:0]  symb_cnt     ,
input [SYM_BW-1:0]  symb_with_err,       

input  [SYM_BW*(T_NUM) - 1:0] err_val,  


input  [SYM_BW*(T_NUM) - 1:0] err_loc,  

output reg [SYM_BW-1:0]  symb_out_cnt,
output reg [0:0]         symb_out_val,
output reg [SYM_BW-1:0]  symb_corrected     

);

// reg               start_1d;       
// reg               start_2d;

reg  [SYM_BW-1:0] err_val_curblk[T_NUM-1:0]    ;
                                      
reg  [SYM_BW-1:0] err_loc_curblk[T_NUM-1:0]    ;

reg  [SYM_BW-1:0] err_val_curblk_1d[T_NUM-1:0]     ;
reg  [SYM_BW-1:0] err_val_curblk_2d[T_NUM-1:0]     ;

reg  [SYM_BW-1:0] err_loc_curblk_1d[T_NUM-1:0]     ;
reg  [SYM_BW-1:0] err_loc_curblk_2d[T_NUM-1:0]     ;

wire  [SYM_BW-1:0] err_val_curblk_w[T_NUM-1:0]     ;
wire  [SYM_BW-1:0] err_loc_curblk_w[T_NUM-1:0]     ;



genvar omega_idx;
generate
    for(omega_idx = 0;omega_idx < T_NUM   ;omega_idx = omega_idx + 1)
    begin
        always @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            err_val_curblk_1d[omega_idx]   <= 0;                                   
            err_loc_curblk_1d[omega_idx]   <= 0;
            err_val_curblk_2d[omega_idx]   <= 0;                                   
            err_loc_curblk_2d[omega_idx]   <= 0;
        end else begin
            err_val_curblk_1d[omega_idx]   <=     err_val_curblk[omega_idx] ;                                                      
            err_loc_curblk_1d[omega_idx]   <=     err_loc_curblk[omega_idx];
            err_val_curblk_2d[omega_idx]   <=     err_val_curblk_1d[omega_idx] ;
            err_loc_curblk_2d[omega_idx]   <=     err_loc_curblk_1d[omega_idx];
        end
    end
endgenerate

generate
    for(omega_idx = 0;omega_idx < T_NUM   ;omega_idx = omega_idx + 1)
    begin
        assign err_val_curblk_w[omega_idx]     =     err_val_curblk_2d[omega_idx] ;                                
        assign err_loc_curblk_w[omega_idx]     =     err_loc_curblk_2d[omega_idx];
    end
endgenerate


// always @(posedge clk or negedge rst_n)
// if (!rst_n) begin
    // start_1d <= 0;
    // start_2d <= 0;
// end else begin
    // start_1d <= start;
    // start_2d <= start_1d;
// end




generate
    for(omega_idx = 0;omega_idx < T_NUM   ;omega_idx = omega_idx + 1)
    begin
        always @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            err_val_curblk[omega_idx]     <= 0;
            err_loc_curblk[omega_idx]     <= 0;
        end else if (start == 1 ) begin
            err_val_curblk[omega_idx]     <= err_val[(omega_idx+1) *SYM_BW - 1:omega_idx *SYM_BW] ;
            err_loc_curblk[omega_idx]     <= err_loc[(omega_idx+1) *SYM_BW - 1:omega_idx *SYM_BW];
        end else ;
    end
endgenerate


generate
    case({T_NUM})
////////////////////////////////////////////////////////////////////////////////////////////
        `R_BW'd16://
            begin
                always @(posedge clk or negedge rst_n)
                if (!rst_n)
                  symb_corrected <= 0;
                else if (symb_cnt != 0 ) begin
                    case(symb_cnt)
                        err_loc_curblk_w[ 0]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 0];
                        err_loc_curblk_w[ 1]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 1];
                        err_loc_curblk_w[ 2]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 2];
                        err_loc_curblk_w[ 3]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 3];
                        err_loc_curblk_w[ 4]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 4];
                        err_loc_curblk_w[ 5]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 5];
                        err_loc_curblk_w[ 6]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 6];
                        err_loc_curblk_w[ 7]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 7];
                        err_loc_curblk_w[ 8]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 8];
                        err_loc_curblk_w[ 9]: symb_corrected <= symb_with_err ^ err_val_curblk_w[ 9];
                        err_loc_curblk_w[10]: symb_corrected <= symb_with_err ^ err_val_curblk_w[10];
                        err_loc_curblk_w[11]: symb_corrected <= symb_with_err ^ err_val_curblk_w[11];
                        err_loc_curblk_w[12]: symb_corrected <= symb_with_err ^ err_val_curblk_w[12];
                        err_loc_curblk_w[13]: symb_corrected <= symb_with_err ^ err_val_curblk_w[13];
                        err_loc_curblk_w[14]: symb_corrected <= symb_with_err ^ err_val_curblk_w[14];
                        err_loc_curblk_w[15]: symb_corrected <= symb_with_err ^ err_val_curblk_w[15]; 
                        default: symb_corrected   <= symb_with_err ;
                    endcase
                end else 
                    symb_corrected   <= 0 ;           
            end
        `R_BW'd8://
            begin
                always @(posedge clk or negedge rst_n)
                if (!rst_n)
                  symb_corrected <= 0;
                else if (symb_cnt != 0 ) begin
                    case(symb_cnt)
                        err_loc_curblk_w[0]: symb_corrected <= symb_with_err ^ err_val_curblk_w[0];
                        err_loc_curblk_w[1]: symb_corrected <= symb_with_err ^ err_val_curblk_w[1];
                        err_loc_curblk_w[2]: symb_corrected <= symb_with_err ^ err_val_curblk_w[2];
                        err_loc_curblk_w[3]: symb_corrected <= symb_with_err ^ err_val_curblk_w[3];
                        err_loc_curblk_w[4]: symb_corrected <= symb_with_err ^ err_val_curblk_w[4];
                        err_loc_curblk_w[5]: symb_corrected <= symb_with_err ^ err_val_curblk_w[5];
                        err_loc_curblk_w[6]: symb_corrected <= symb_with_err ^ err_val_curblk_w[6];
                        err_loc_curblk_w[7]: symb_corrected <= symb_with_err ^ err_val_curblk_w[7];
                        default: symb_corrected   <= symb_with_err ;
                    endcase
                end else
                    symb_corrected   <= 0 ;
            end
        `R_BW'd4://
            begin
                always @(posedge clk or negedge rst_n)
                if (!rst_n)
                  symb_corrected <= 0;
                else if (symb_cnt != 0 ) begin
                    case(symb_cnt)
                        err_loc_curblk_w[0]: symb_corrected <= symb_with_err ^ err_val_curblk_w[0];
                        err_loc_curblk_w[1]: symb_corrected <= symb_with_err ^ err_val_curblk_w[1];
                        err_loc_curblk_w[2]: symb_corrected <= symb_with_err ^ err_val_curblk_w[2];
                        err_loc_curblk_w[3]: symb_corrected <= symb_with_err ^ err_val_curblk_w[3];
                        default: symb_corrected   <= symb_with_err ;
                    endcase
                end else
                    symb_corrected   <= 0 ;
            end
        `R_BW'd2://
            begin
                always @(posedge clk or negedge rst_n)
                if (!rst_n)
                  symb_corrected <= 0;
                else if (symb_cnt != 0 ) begin
                    case(symb_cnt)
                        err_loc_curblk_w[0]: symb_corrected <= symb_with_err ^ err_val_curblk_w[0];
                        err_loc_curblk_w[1]: symb_corrected <= symb_with_err ^ err_val_curblk_w[1];
                        default: symb_corrected   <= symb_with_err ;
                    endcase
                end else
                    symb_corrected   <= 0 ;
            end
        `R_BW'd1://
            begin
                always @(posedge clk or negedge rst_n)
                if (!rst_n)
                  symb_corrected <= 0;
                else if (symb_cnt != 0 ) begin
                    case(symb_cnt)
                        err_loc_curblk_w[0]: symb_corrected <= symb_with_err ^ err_val_curblk_w[0];
                        default: symb_corrected   <= symb_with_err ;
                    endcase
                end else
                    symb_corrected   <= 0 ;
            end
            
    endcase
endgenerate 
       



always @(posedge clk or negedge rst_n)
if (!rst_n)
  symb_out_cnt <= 0;
else 
  symb_out_cnt   <= symb_cnt ;   


always @(posedge clk or negedge rst_n)
if (!rst_n)
  symb_out_val   <= 0;
else if(symb_cnt <= N_NUM && symb_cnt >= 8'd1 )
  symb_out_val   <= 1 ; 
else
  symb_out_val   <= 0;
  
endmodule       