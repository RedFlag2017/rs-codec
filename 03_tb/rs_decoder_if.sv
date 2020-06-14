

interface rs_decoder_if ();
// parameter `BLK_NUM = 1;
// parameter `N_NUM = 255;
parameter K_MSG_LEN = `N_NUM - `R_NUM;

logic clk            ;
logic rst_n          ;
logic din_val        ;
logic din_sop        ;
logic din_eop        ;
logic [`SYM_BW-1:0] din      ;
logic [4-1:0] sym_width      ;

                     
// logic [`SYM_BW-1:0] err_loc1      ;
// logic [`SYM_BW-1:0] err_loc2      ;
// logic [`SYM_BW-1:0] err_loc3      ;
// logic [`SYM_BW-1:0] err_loc4      ;
// logic [`SYM_BW-1:0] err_loc5      ;
// logic [`SYM_BW-1:0] err_loc6      ;
// logic [`SYM_BW-1:0] err_loc7      ;
// logic [`SYM_BW-1:0] err_loc8      ;

// logic [`SYM_BW-1:0] err_val1      ;
// logic [`SYM_BW-1:0] err_val2      ;
// logic [`SYM_BW-1:0] err_val3      ;
// logic [`SYM_BW-1:0] err_val4      ;
// logic [`SYM_BW-1:0] err_val5      ;
// logic [`SYM_BW-1:0] err_val6      ;
// logic [`SYM_BW-1:0] err_val7      ;
// logic [`SYM_BW-1:0] err_val8      ;
// logic [2:0] error_num;
// logic dec_done       ;
// logic dec_fail       ;

logic [`SYM_BW - 1:0] symb_out_cnt  ;
logic                symb_out_val  ;
logic [`SYM_BW - 1:0] symb_corrected; 
      

logic busy           ;


logic   [`SYM_BW  -1:0]  data_with_err_mem_buf[`N_NUM*`BLK_NUM];
logic   [`SYM_BW  -1:0]  data_out_golden_mem_buf[`N_NUM*`BLK_NUM];

string data_decode_out_golden_file   = "../03_tb/alg_rm/data_save/data_decoder_out.txt";
string data_with_err_file = "../03_tb/alg_rm/data_save/data_with_err.txt";

// int blk_idx = 0;
// int k = 0;

int blk_idx1 = 0;
int blk_idx2 = 0;
int k = 0;
string log_info; 


int code_idx = 0;
bit fail     = 0;
string test_log_file = {"../test_dec.log"};
string cur_date_time;
string test_name;

integer file; 




task random_gen();

   $readmemh(data_with_err_file, data_with_err_mem_buf);
   din_sop <= 0;
   din_val <= 0;
   din_eop <= 0;
   sym_width <= 0;   
   
   din <= 0;
   @(negedge rst_n);@(posedge rst_n);   
   sym_width <= `SYM_BW;   
   repeat(20 )@(posedge clk);

  

   for (blk_idx1=0;blk_idx1< `BLK_NUM;blk_idx1++) begin
        
       din_sop <= 1;
       din_val <= 1;
       din_eop <= 0;
       din <= {{(8-`SYM_BW){1'b0}},data_with_err_mem_buf[blk_idx1*`N_NUM +0]};//        
       @(posedge clk);   
       din_sop <= 0;
       
       
       for( k=1;k<`N_NUM;k++) begin
           if(k==`N_NUM-1)
           begin
               din_eop <= 1;
           end
           // din <= data_with_err_mem_buf[blk_idx1*`N_NUM +k];//
           din <= {{(8-`SYM_BW){1'b0}},data_with_err_mem_buf[blk_idx1*`N_NUM +k]};//        
           @(posedge clk);  
           din_eop <= 0;
           
       end
       din_val <= 0;

       repeat (2)@(posedge clk);//
   end
   
   //wait decode process over
   repeat (`N_NUM*5)@(posedge clk);
   
   $finish();



endtask
 
 
task rs_dec_check();
    if ($value$plusargs("SYS_DATE_TIME=%s",cur_date_time))
    begin
    $display(" SYS_DATE_TIME= %s.",cur_date_time);
    
    end
    // if ($value$plusargs("UVM_TESTNAME=%s",test_name))
    // begin
    // $display(" UVM_TESTNAME= %s.",test_name);
    
    // end    

    $readmemh(data_decode_out_golden_file, data_out_golden_mem_buf);
    repeat(`BLK_NUM) begin
          
        code_idx = 0;
        @(posedge clk);
        wait(symb_out_val == 1);
        `uvm_info("DEBUG","New Block Data!",UVM_NONE); 
        
        repeat(`N_NUM) begin
            @(posedge clk);
            if(data_out_golden_mem_buf[blk_idx2*`N_NUM + code_idx] != symb_corrected || symb_out_val == 0) begin
                fail = 1;
                $sformat(log_info,"blk_idx2 = [%d]; code_idx = [%d] ",blk_idx2,code_idx);
                `uvm_error( "DEBUG",log_info );
            end
                        
            code_idx++;
        end
        blk_idx2++;
        
    end
    
    file=$fopen(test_log_file,"a+");
    $sformat(log_info,"M=%1d;N=%3d;K=%3d;R=%2d;   Result=%s  @%s",`SYM_BW,`N_NUM,K_MSG_LEN,`R_NUM,(fail)? "Fail":"Pass",cur_date_time);
    
    $fdisplay(file,"%s",log_info);
    
    $fclose(file);    
    

 endtask 





endinterface