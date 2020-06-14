`timescale 1ns/100ps
module rs_dec_ip
// #(
// parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
// parameter [8-1:0]  N_NUM = 255,
// parameter [`R_BW - 1 :0]  R_NUM = 16,
// parameter [`R_BW - 1 :0]  T_NUM = R_NUM/2

// ) 
(
      input clk,
      input rst_n,
      input din_val,
      input din_sop,
      input din_eop,
      input  [8 - 1:0] din,
      input  [4 - 1:0] sym_width,

      output reg [8 - 1:0] symb_out_cnt  ,
      output reg           symb_out_val  ,
      output reg [8 - 1:0] symb_corrected 
      
      // output [3:0] error_num,
      // output dec_done,
      // output dec_fail,
      // output busy
      );
 
 
wire [3 - 1:0] symb3_out_cnt  ;
wire           symb3_out_val  ;
wire [3 - 1:0] symb3_corrected;

wire [4 - 1:0] symb4_out_cnt  ;
wire           symb4_out_val  ;
wire [4 - 1:0] symb4_corrected;

wire [5 - 1:0] symb5_out_cnt  ;
wire           symb5_out_val  ;
wire [5 - 1:0] symb5_corrected;

wire [6 - 1:0] symb6_out_cnt  ;
wire           symb6_out_val  ;
wire [6 - 1:0] symb6_corrected;

wire [7 - 1:0] symb7_out_cnt  ;
wire           symb7_out_val  ;
wire [7 - 1:0] symb7_corrected;

wire [8 - 1:0] symb8_out_cnt  ;
wire           symb8_out_val  ;
wire [8 - 1:0] symb8_corrected;


 

reg [3:0] sym_width_d;
always @(posedge clk or negedge rst_n)
if (!rst_n) begin
  sym_width_d <= 0;  
end else begin
  sym_width_d <= sym_width;  
end


 
rs_decoder #(
.SYM_BW(3),
.N_NUM(7),
.R_NUM(4)
) 
u3_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[2:0]            ),
           
.symb_out_cnt    ( symb3_out_cnt   ),
.symb_out_val    ( symb3_out_val   ),
.symb_corrected  ( symb3_corrected )
      

// .busy           (  )
 );


rs_decoder #(
.SYM_BW(4),
.N_NUM(15),
.R_NUM(4)
) 
u4_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[3:0]            ),
           
.symb_out_cnt    ( symb4_out_cnt   ),
.symb_out_val    ( symb4_out_val   ),
.symb_corrected  ( symb4_corrected ) 
      

// .busy           (  )
 );
 
 
rs_decoder #(
.SYM_BW(5),
.N_NUM(31),
.R_NUM(8)
) 
u5_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[4:0]            ),
           
.symb_out_cnt    ( symb5_out_cnt   ),
.symb_out_val    ( symb5_out_val   ),
.symb_corrected  ( symb5_corrected ) 
      

// .busy           (  )
 ); 

rs_decoder #(
.SYM_BW(6),
.N_NUM(63),
.R_NUM(8)
) 
u6_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[5:0]            ),
           
.symb_out_cnt    ( symb6_out_cnt   ),
.symb_out_val    ( symb6_out_val   ),
.symb_corrected  ( symb6_corrected ) 
      

// .busy           (  )
 ); 

rs_decoder #(
.SYM_BW(7),
.N_NUM(127),
.R_NUM(16)
) 
u7_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[6:0]            ),
           
.symb_out_cnt    ( symb7_out_cnt   ),
.symb_out_val    ( symb7_out_val   ),
.symb_corrected  ( symb7_corrected ) 
      

// .busy           (  )
 ); 

rs_decoder #(
.SYM_BW(8),
.N_NUM(255),
.R_NUM(32)
) 
u8_rs_decoder(
.clk            (clk            ),
.rst_n          (rst_n          ),
.din_val        (din_val        ),
.din_sop        (din_sop        ),
.din_eop        (din_eop        ),
.din            (din[7:0]            ),
           
.symb_out_cnt    ( symb8_out_cnt   ),
.symb_out_val    ( symb8_out_val   ),
.symb_corrected  ( symb8_corrected )
      

// .busy           (  )
 ); 


always @(posedge clk or negedge rst_n)
if (!rst_n) begin
    symb_out_cnt   <= 1'b0 ;
    symb_out_val   <= 1'b0 ;
    symb_corrected <= 8'b0;
    
end else 
begin 
    case (sym_width_d)
        4'd3:
            begin
                symb_out_cnt   <= {{(5){1'b0}},symb3_out_cnt }  ;
                symb_out_val   <= symb3_out_val   ;
                symb_corrected <= {{(5){1'b0}},symb3_corrected }  ;
            end
        4'd4:
            begin
                symb_out_cnt   <= {{(4){1'b0}},symb4_out_cnt }   ;
                symb_out_val   <= symb4_out_val   ;
                symb_corrected <= {{(4){1'b0}},symb4_corrected } ;            
            end
        4'd5:
            begin
                symb_out_cnt   <= {{(3){1'b0}},symb5_out_cnt   } ;
                symb_out_val   <= symb5_out_val   ;
                symb_corrected <= {{(3){1'b0}},symb5_corrected}  ;           
            end
        4'd6:
            begin
                symb_out_cnt   <= {{(2){1'b0}},symb6_out_cnt }   ;
                symb_out_val   <= symb6_out_val   ;
                symb_corrected <= {{(2){1'b0}},symb6_corrected}  ;            
            end
        4'd7:
            begin
                symb_out_cnt   <= {{(1){1'b0}},symb7_out_cnt }   ;
                symb_out_val   <= symb7_out_val   ;
                symb_corrected <= {{(1){1'b0}},symb7_corrected } ;           
            end
        4'd8:
            begin
                symb_out_cnt   <= symb8_out_cnt   ;
                symb_out_val   <= symb8_out_val   ;
                symb_corrected <= symb8_corrected ;            
            end        
    endcase
end

endmodule

// r_dict = {
// '3':[4 ],
// '4':[4 ],
// '5':[8 ],
// '6':[8 ],
// '7':[16 ],
// '8':[32 ]
// }
// n_dict = {
// '3':[ 7 ],
// '4':[15 ],
// '5':[31 ],
// '6':[63 ],
// '7':[127],
// '8':[255]
// }