`timescale 1ns/100ps
module syndrome
#(
parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
parameter [8-1:0]  N_NUM = 255,
parameter [`R_BW - 1 :0]  R_NUM = 16,
parameter [`R_BW - 1 :0]  T_NUM = R_NUM/2
) 
(
    input clk,
    input rst_n,
    input din_val,
    input din_sop,
    input din_eop,
    input [SYM_BW - 1:0] din,
    output reg syndrome_val,

    output reg [SYM_BW*R_NUM - 1:0] syndrome 
    );


        
wire [SYM_BW-1:0] alpha_c[32 - 1:0]  ;

generate
    case({SYM_BW})
////////////////////////////////////////////////////////////////////////////////////////////
        4'd3://
           begin: alpha_c_3
                assign alpha_c[0 ]  =  3'h2;
                assign alpha_c[1 ]  =  3'h4;
                assign alpha_c[2 ]  =  3'h3;
                assign alpha_c[3 ]  =  3'h6;                 
           end
        4'd4://
           begin: alpha_c_4 
                assign alpha_c[0 ]  =  4'd 2;
                assign alpha_c[1 ]  =  4'd 4;
                assign alpha_c[2 ]  =  4'd 8;
                assign alpha_c[3 ]  =  4'd 3; 
                assign alpha_c[4 ]  =  4'd 6;
                assign alpha_c[5 ]  =  4'd12;
                assign alpha_c[6 ]  =  4'd11;
                assign alpha_c[7 ]  =  4'd 5;
           end
        4'd5://
           begin: alpha_c_5 
                assign alpha_c[0 ]  =  5'd 2;
                assign alpha_c[1 ]  =  5'd 4;
                assign alpha_c[2 ]  =  5'd 8;
                assign alpha_c[3 ]  =  5'd16; 
                assign alpha_c[4 ]  =  5'd 5;
                assign alpha_c[5 ]  =  5'd10;
                assign alpha_c[6 ]  =  5'd20;
                assign alpha_c[7 ]  =  5'd13; 
                assign alpha_c[8 ]  =  5'd26;
                assign alpha_c[9 ]  =  5'd17;
                assign alpha_c[10]  =  5'd 7;
                assign alpha_c[11]  =  5'd14; 
                assign alpha_c[12]  =  5'd28;
                assign alpha_c[13]  =  5'd29;
                assign alpha_c[14]  =  5'd31;
                assign alpha_c[15]  =  5'd27;
           end
        4'd6://
           begin: alpha_c_6 
                assign alpha_c[0 ]  =  6'd 2;
                assign alpha_c[1 ]  =  6'd 4;
                assign alpha_c[2 ]  =  6'd 8;
                assign alpha_c[3 ]  =  6'd16; 
                assign alpha_c[4 ]  =  6'd32;
                assign alpha_c[5 ]  =  6'd 3;
                assign alpha_c[6 ]  =  6'd 6;
                assign alpha_c[7 ]  =  6'd12; 
                assign alpha_c[8 ]  =  6'd24;
                assign alpha_c[9 ]  =  6'd48;
                assign alpha_c[10]  =  6'd35;
                assign alpha_c[11]  =  6'd 5; 
                assign alpha_c[12]  =  6'd10;
                assign alpha_c[13]  =  6'd20;
                assign alpha_c[14]  =  6'd40;
                assign alpha_c[15]  =  6'd19;  
                assign alpha_c[16]  =  6'd38;
                assign alpha_c[17]  =  6'd15;
                assign alpha_c[18]  =  6'd30;
                assign alpha_c[19]  =  6'd60;
                assign alpha_c[20]  =  6'd59;
                assign alpha_c[21]  =  6'd53;
                assign alpha_c[22]  =  6'd41;
                assign alpha_c[23]  =  6'd17;
                assign alpha_c[24]  =  6'd34;
                assign alpha_c[25]  =  6'd 7;
                assign alpha_c[26]  =  6'd14;
                assign alpha_c[27]  =  6'd28;
                assign alpha_c[28]  =  6'd56;
                assign alpha_c[29]  =  6'd51;
                assign alpha_c[30]  =  6'd37;
                assign alpha_c[31]  =  6'd 9; 
           end
        4'd7://
           begin: alpha_c_7 
                assign alpha_c[0 ]  =  7'd  2;
                assign alpha_c[1 ]  =  7'd  4;
                assign alpha_c[2 ]  =  7'd  8;
                assign alpha_c[3 ]  =  7'd 16; 
                assign alpha_c[4 ]  =  7'd 32;
                assign alpha_c[5 ]  =  7'd 64;
                assign alpha_c[6 ]  =  7'd  9;
                assign alpha_c[7 ]  =  7'd 18; 
                assign alpha_c[8 ]  =  7'd 36;
                assign alpha_c[9 ]  =  7'd 72;
                assign alpha_c[10]  =  7'd 25;
                assign alpha_c[11]  =  7'd 50; 
                assign alpha_c[12]  =  7'd100;
                assign alpha_c[13]  =  7'd 65;
                assign alpha_c[14]  =  7'd 11;
                assign alpha_c[15]  =  7'd 22;  
                assign alpha_c[16]  =  7'd 44;
                assign alpha_c[17]  =  7'd 88;
                assign alpha_c[18]  =  7'd 57;
                assign alpha_c[19]  =  7'd114;
                assign alpha_c[20]  =  7'd109;
                assign alpha_c[21]  =  7'd 83;
                assign alpha_c[22]  =  7'd 47;
                assign alpha_c[23]  =  7'd 94;
                assign alpha_c[24]  =  7'd 53;
                assign alpha_c[25]  =  7'd106;
                assign alpha_c[26]  =  7'd 93;
                assign alpha_c[27]  =  7'd 51;
                assign alpha_c[28]  =  7'd102;
                assign alpha_c[29]  =  7'd 69;
                assign alpha_c[30]  =  7'd  3;
                assign alpha_c[31]  =  7'd  6;                 
           end
        4'd8://
            begin: alpha_c_8 
                assign alpha_c[0 ]  =  8'h02;//02
                assign alpha_c[1 ]  =  8'h04;//04
                assign alpha_c[2 ]  =  8'h08;//08
                assign alpha_c[3 ]  =  8'h10;//10 
                assign alpha_c[4 ]  =  8'h20;//20
                assign alpha_c[5 ]  =  8'h40;//40
                assign alpha_c[6 ]  =  8'h80;//80
                assign alpha_c[7 ]  =  8'h1d;//1D 
                assign alpha_c[8 ]  =  8'h3A;//3A
                assign alpha_c[9 ]  =  8'h74;//74
                assign alpha_c[10]  =  8'hE8;//E8
                assign alpha_c[11]  =  8'hCD;//CD 
                assign alpha_c[12]  =  8'h87;//87
                assign alpha_c[13]  =  8'h13;//13
                assign alpha_c[14]  =  8'h26;//26
                assign alpha_c[15]  =  8'h4C;//4C  
                assign alpha_c[16]  =  8'h98;//98
                assign alpha_c[17]  =  8'h2D;//2D
                assign alpha_c[18]  =  8'h5A;//5A
                assign alpha_c[19]  =  8'hB4;//B4
                assign alpha_c[20]  =  8'h75;//75
                assign alpha_c[21]  =  8'hEA;//EA
                assign alpha_c[22]  =  8'hC9;//C9
                assign alpha_c[23]  =  8'h8F;//8F
                assign alpha_c[24]  =  8'h03;//03
                assign alpha_c[25]  =  8'h06;//06
                assign alpha_c[26]  =  8'h0C;//0C
                assign alpha_c[27]  =  8'h18;//18
                assign alpha_c[28]  =  8'h30;//30
                assign alpha_c[29]  =  8'h60;//60
                assign alpha_c[30]  =  8'hC0;//C0
                assign alpha_c[31]  =  8'h9D;//9D
            end                
    endcase
endgenerate    
 

wire [SYM_BW - 1:0] sp[R_NUM-1:0];


genvar r_idx;
generate
    for(r_idx = 0;r_idx < R_NUM ;r_idx = r_idx + 1)
    begin
        case({SYM_BW})
            {4'd3}:
            begin:gf8mul_dec
                 gf8mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));        
            end
            {4'd4}:
            begin:gf16mul_dec
                 gf16mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));        
            end
            {4'd5}:
            begin:gf32mul_dec
                 gf32mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));        
            end
            {4'd6}:
            begin:gf64mul_dec
                 gf64mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));        
            end
            {4'd7}:
            begin:gf128mul_dec
                 gf128mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));        
            end
            
            {4'd8}:
            begin:gf256mul_dec
                gf256mul_dec mul_blk(.a(alpha_c[r_idx]), .b(syndrome[(r_idx+1)*SYM_BW - 1:r_idx*SYM_BW] ),  .z(sp[r_idx]));          
            end
        endcase
              
    end
endgenerate


generate
    for(r_idx = 0;r_idx < R_NUM ;r_idx = r_idx + 1)
    begin
        always @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            syndrome[(r_idx+1) *SYM_BW - 1:r_idx *SYM_BW] <= {SYM_BW{1'b0}};
        end else if (din_val) begin
            if (din_sop) begin
                syndrome[(r_idx+1) *SYM_BW - 1:r_idx *SYM_BW]  <=  din;
            end else begin
                syndrome[(r_idx+1) *SYM_BW - 1:r_idx *SYM_BW]  <= sp[r_idx ] ^ din;
            end
        end else begin
                syndrome[(r_idx+1) *SYM_BW - 1:r_idx *SYM_BW]  <=  {SYM_BW{1'b0}};
        end
    end
endgenerate



    
always @(posedge clk or negedge rst_n)
if (!rst_n)
  syndrome_val <= {SYM_BW{1'b0}};
else
  syndrome_val <= din_eop;



endmodule