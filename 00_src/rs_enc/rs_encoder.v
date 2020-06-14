
`timescale 1ns/100ps

module rs_encoder 
#(
parameter [`SYM_BW_BW -1 :0] SYM_BW = 8,
parameter [8-1:0]  N_NUM = 255,
parameter [`R_BW - 1 :0]  R_NUM = 16
) 
(
    input         clk,
    input         rst_n,
    input         din_val,
    input         din_sop,
    // input         din_eop,
    input [SYM_BW-1:0]   din,
    output        dout_val,
    output        dout_sop,
    output        dout_eop,
    output [SYM_BW-1:0]  dout
    // output        busy
);


rs_lfsr 
#(  
    .SYM_BW(SYM_BW),
    .N_NUM(N_NUM),
    .R_NUM(R_NUM)
) u_rs_lfsr
(
.clk      (clk     ),
.rst_n    (rst_n   ),
.din_val  (din_val ),
.din_sop  (din_sop ),
// .din_eop  (din_eop ),
.din      (din     ),
.dout_val (dout_val),
.dout_sop (dout_sop),
.dout_eop (dout_eop),
.dout     (dout    )
// .busy     (busy    )
);

endmodule