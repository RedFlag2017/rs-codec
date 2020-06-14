
`timescale 1ns/100ps

module rs_enc_ip 
(
    input          clk,
    input          rst_n,
    input          din_val,
    input          din_sop,
    // input          din_eop,
    input [8-1:0]  din,
    input [3:0]    sym_width,
    output reg         dout_val,
    output reg         dout_sop,
    output reg         dout_eop,
    output reg [8-1:0] dout
    // output reg         busy
);

wire         dout3_val;
wire         dout3_sop;
wire         dout3_eop;
wire [3-1:0] dout3    ;
// wire         busy3    ;

wire         dout4_val;
wire         dout4_sop;
wire         dout4_eop;
wire [4-1:0] dout4    ;
// wire         busy4    ;

wire         dout5_val;
wire         dout5_sop;
wire         dout5_eop;
wire [5-1:0] dout5    ;
// wire         busy5    ;

wire         dout6_val;
wire         dout6_sop;
wire         dout6_eop;
wire [6-1:0] dout6    ;
// wire         busy6    ;

wire         dout7_val;
wire         dout7_sop;
wire         dout7_eop;
wire [7-1:0] dout7    ;
// wire         busy7    ;

wire         dout8_val;
wire         dout8_sop;
wire         dout8_eop;
wire [8-1:0] dout8    ;
// wire         busy8    ;



reg [3:0] sym_width_d;
always @(posedge clk or negedge rst_n)
if (!rst_n) begin
  sym_width_d <= 0;  
end else begin
  sym_width_d <= sym_width;  
end




rs_lfsr 
#(
.SYM_BW(3),
.N_NUM(7),
.R_NUM(4)
) u_rs_lfsr3
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd3)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[2:0]     ),
.dout_val (dout3_val),
.dout_sop (dout3_sop),
.dout_eop (dout3_eop),
.dout     (dout3    )
// .busy     (busy3    )
);

rs_lfsr 
#(  
.SYM_BW(4),
.N_NUM(15),
.R_NUM(4)
) u_rs_lfsr4
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd4)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[3:0]     ),
.dout_val (dout4_val),
.dout_sop (dout4_sop),
.dout_eop (dout4_eop),
.dout     (dout4    )
// .busy     (busy4    )
);


rs_lfsr 
#(  
    .SYM_BW(5),
    .N_NUM(31),
    .R_NUM(8)
) u_rs_lfsr5
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd5)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[4:0]     ),
.dout_val (dout5_val),
.dout_sop (dout5_sop),
.dout_eop (dout5_eop),
.dout     (dout5    )
// .busy     (busy5    )
);


rs_lfsr 
#(  
    .SYM_BW(6),
    .N_NUM(63),
    .R_NUM(8)
) u_rs_lfsr6
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd6)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[5:0]     ),
.dout_val (dout6_val),
.dout_sop (dout6_sop),
.dout_eop (dout6_eop),
.dout     (dout6    )
// .busy     (busy6    )
);


rs_lfsr 
#(  
    .SYM_BW(7),
    .N_NUM(127),
    .R_NUM(16)
) u_rs_lfsr7
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd7)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[6:0]     ),
.dout_val (dout7_val),
.dout_sop (dout7_sop),
.dout_eop (dout7_eop),
.dout     (dout7    )
// .busy     (busy7    )
);


rs_lfsr 
#(  
    .SYM_BW(8),
    .N_NUM(255),
    .R_NUM(32)
) u_rs_lfsr8
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val & (sym_width_d == 4'd8)),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din[7:0]     ),
.dout_val (dout8_val),
.dout_sop (dout8_sop),
.dout_eop (dout8_eop),
.dout     (dout8    )
// .busy     (busy8    )
);


always @(posedge clk or negedge rst_n)
if (!rst_n) begin
    dout_val <= 1'b0 ;
    dout_sop <= 1'b0 ;
    dout_eop <= 1'b0 ;
    dout     <= 8'b0;
end else 
begin 
    case (sym_width_d)
        4'd3:
            begin
                dout_val <= dout3_val ;
                dout_sop <= dout3_sop ;
                dout_eop <= dout3_eop ;
                dout     <= {{(5){1'b0}},dout3    };
                // busy     = busy3     ;           
            end
        4'd4:
            begin
                dout_val <= dout4_val ;
                dout_sop <= dout4_sop ;
                dout_eop <= dout4_eop ;
                dout     <= {{(4){1'b0}},dout4     };
                // busy     = busy4     ;           
            end
        4'd5:
            begin
                dout_val <= dout5_val ;
                dout_sop <= dout5_sop ;
                dout_eop <= dout5_eop ;
                dout     <= {{(3){1'b0}},dout5     };
                // busy     = busy5     ;           
            end
        4'd6:
            begin
                dout_val <= dout6_val ;
                dout_sop <= dout6_sop ;
                dout_eop <= dout6_eop ;
                dout     <= {{(2){1'b0}},dout6     };
                // busy     = busy6     ;           
            end
        4'd7:
            begin
                dout_val <= dout7_val ;
                dout_sop <= dout7_sop ;
                dout_eop <= dout7_eop ;
                dout     <= {{(1){1'b0}},dout7     };
                // busy     = busy7     ;           
            end
        4'd8:
            begin
                dout_val <= dout8_val ;
                dout_sop <= dout8_sop ;
                dout_eop <= dout8_eop ;
                dout     <= dout8     ;
                // busy     = busy8     ;           
            end        
    endcase
end




endmodule