`timescale 1ns/100ps
module rs_decoder
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
      input  [SYM_BW - 1:0] din,

      output [SYM_BW - 1:0] symb_out_cnt  ,
      output                symb_out_val  ,
      output [SYM_BW - 1:0] symb_corrected
      
      // output [3:0] error_num,
      // output dec_done,
      // output dec_fail,
      // output busy
      );

localparam T = R_NUM/2;


wire syndrome_val;
wire dec_done2;
wire kes_ok;

// wire [4:0] error_num;
wire       dec_done ;
// wire       dec_fail ;

wire [SYM_BW*R_NUM - 1:0] syndrome ;
  
wire [SYM_BW*T_NUM - 1:0] err_loc ;    
                            
wire [SYM_BW*T_NUM - 1:0] err_val ; 

wire [SYM_BW*(T_NUM+1) - 1:0] lamda ; 

wire [SYM_BW*(T_NUM) - 1:0] omega ; 

wire [SYM_BW*(T_NUM) - 1:0] err_loc_out ; 

wire err_val_done;


assign dec_done = err_val_done ;

syndrome 
#(
.SYM_BW(SYM_BW),
.N_NUM (N_NUM),
.R_NUM (R_NUM)
) 
u_syndrome(
       .clk          (clk         ) ,
       .rst_n        (rst_n       ) ,
       .din_val      (din_val     ) ,
       .din_sop      (din_sop     ) ,
       .din_eop      (din_eop     ) ,
       .din          (din         ) ,
       .syndrome_val (syndrome_val) ,
       .syndrome(syndrome)         
       );


kes 
#(
.SYM_BW(SYM_BW),
.N_NUM (N_NUM),
.R_NUM (R_NUM),
.T_NUM (T_NUM)
) 
u_kes(
       .clk       (clk      ) ,
       .rst_n     (rst_n    ) ,
       .start     (syndrome_val) ,

       .syndrome  (syndrome) ,
       .lamda     (lamda     ) ,
       .omega     (omega) ,
       // .error_num (error_num) ,
       .done      (kes_ok) 
       // .fail      (dec_fail )
       );       
       

err_locate 
#(
.SYM_BW(SYM_BW),
.N_NUM (N_NUM),
.R_NUM (R_NUM),
.T_NUM (T_NUM)
) 
u_err_locate(
       .clk       (clk      ) ,
       .rst_n     (rst_n    ) ,
       .start     (kes_ok) ,       
       // .error_num (error_num) ,
       .lamda      (lamda) ,       
       .err_loc   (err_loc) ,       
       .done      (chien_ok ) 
       );

err_value 
#(
.SYM_BW(SYM_BW),
.N_NUM (N_NUM),
.R_NUM (R_NUM),
.T_NUM (T_NUM)
) 
u_err_value(
    .clk      (clk      ),
    .rst_n    (rst_n    ),
    .start    (chien_ok),
    // .start    (kes_ok),       
    // .error_num(error_num),
    .lamda      (lamda) ,
    .omega   (omega) ,   
    .err_loc (err_loc),
    .err_val (err_val),
    .err_loc_out(err_loc_out),       
    .done     (err_val_done)
    );
       

wire fifo_rd;
wire [SYM_BW-1:0] fifo_data_out;


generate    
    case({SYM_BW})
        {4'd3}:
        begin:u_fifo_buffer_3bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 32)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end
        {4'd4}:
        begin:u_fifo_buffer_4bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 64)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end
        {4'd5}:
        begin:u_fifo_buffer_5bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 128)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end 
        {4'd6}:
        begin:u_fifo_buffer_6bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 256)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end         
        {4'd7}:
        begin:u_fifo_buffer_7bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 512)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end
        {4'd8}:
        begin:u_fifo_buffer_8bit
            fifo_buffer 
            #(
            .SYM_BW(SYM_BW),
            .DEPTH ( 1024)
            ) 
            u_fifo_buffer(
            .clk     (clk),
            .rst     (~rst_n), 
            .datain  (din),
            .rd      (fifo_rd),
            .wr      (din_val), 
            .dataout (fifo_data_out),
            .full    (), 
            .empty   ()
            );
        end        
    endcase    
endgenerate 




wire [SYM_BW-1:0] symb_cnt; 
wire [SYM_BW-1:0] symb_with_err; 

dec_ctrl 
#(
.SYM_BW(SYM_BW ),
.N_NUM (N_NUM  ),
.R_NUM (R_NUM  ),
.T_NUM (T_NUM)
) u_dec_ctrl
(
.clk             (clk),
.rst_n           (rst_n),
.err_loc_val_sync(err_val_done),
.fifo_rd         (fifo_rd),
.fifo_out        (fifo_data_out),
.symbol_cnt      (symb_cnt),
.symbol_out      (symb_with_err)
);   



err_correct 
#(
.SYM_BW(SYM_BW ),
.N_NUM (N_NUM  ),
.R_NUM (R_NUM  ),
.T_NUM (T_NUM)
) u_err_correct
(
.clk            (clk),
.rst_n          (rst_n),
.start          (err_val_done),
// .error_num      (),
                
.symb_cnt       (symb_cnt),
.symb_with_err  (symb_with_err),       
                
.err_val       (err_val), 
.err_loc      (err_loc_out),         
              
.symb_out_cnt  (symb_out_cnt  ),
.symb_out_val  (symb_out_val  ),
.symb_corrected(symb_corrected)     

);  

endmodule