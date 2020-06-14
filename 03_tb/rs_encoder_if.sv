


// `define SYM_BW 3
// `define R_NUM  4

interface rs_encoder_if ();

parameter K_MSG_LEN = `N_NUM - `R_NUM;


logic       clk     ;
logic       rst_n   ;
logic       din_val ;
logic       din_sop ;
logic       din_eop ;
logic [8 - 1:0] din     ;
logic [4 - 1:0] sym_width     ;

logic       dout_val;
logic       dout_sop;
logic       dout_eop;
logic [8 - 1:0] dout    ;
logic       busy    ;


logic   [`SYM_BW  -1:0]  data_in_mem_buf[K_MSG_LEN*`BLK_NUM];
logic   [`SYM_BW  -1:0]  data_out_golden_mem_buf[`N_NUM*`BLK_NUM];

string enc_data_in_file      = "../03_tb/alg_rm/data_save/data_encoder_in.txt";
string enc_data_out_golden_file      = "../03_tb/alg_rm/data_save/data_encoder_out.txt";

int blk_idx1 = 0;
int blk_idx2 = 0;
int k = 0;
string log_info; 


int code_idx = 0;
bit fail     = 0;
string test_log_file = {"../test_enc.log"};
string cur_date_time;
string test_name;

integer file; 


 task random_gen();
    sym_width <= 0;
    $readmemh(enc_data_in_file, data_in_mem_buf);
    din_sop <= 0;
    din_val <= 0;
    din_eop <= 0;
    
    din <= 0;
    @(negedge rst_n);@(posedge rst_n);    
    sym_width <= `SYM_BW;
    repeat(20 )@(posedge clk);
    
    

   

    for (blk_idx1=0;blk_idx1< `BLK_NUM;blk_idx1++) begin
         
        din_sop <= 1;
        din_val <= 1;
        din_eop <= 0;
        din <= data_in_mem_buf[blk_idx1*K_MSG_LEN +0][`SYM_BW - 1:0];//        
        @(posedge clk);   
        din_sop <= 0;
        
        
        for( k=1;k<K_MSG_LEN;k++) begin
            if(k==K_MSG_LEN-1)
            begin
                din_eop <= 1;
            end
            $sformat(log_info,"data_in_mem_buf[%d]=%d",blk_idx1*K_MSG_LEN +k,data_in_mem_buf[blk_idx1*K_MSG_LEN +k]);
            `uvm_info("DEBUG",log_info,UVM_HIGH);
            din <= data_in_mem_buf[blk_idx1*K_MSG_LEN +k][`SYM_BW - 1:0];//
            @(posedge clk);  
            din_eop <= 0;
            
        end
        din_val <= 0;

        repeat (`R_NUM)@(posedge clk);
    end
    
    
    repeat (10)@(posedge clk);
    $sformat(log_info,"Simulation is Over,  log file: %s , the result is %s\n\n\n",test_log_file,(fail == 1 )? "Fail": "Pass");
    `uvm_info("DEBUG",log_info,UVM_NONE);    
    
    $finish();



 endtask



task rs_enc_check();
    if ($value$plusargs("SYS_DATE_TIME=%s",cur_date_time))
    begin
    $display(" SYS_DATE_TIME= %s.",cur_date_time);
    
    end
    // if ($value$plusargs("UVM_TESTNAME=%s",test_name))
    // begin
    // $display(" UVM_TESTNAME= %s.",test_name);
    
    // end    

    $readmemh(enc_data_out_golden_file, data_out_golden_mem_buf);
    repeat(`BLK_NUM) begin
        code_idx = 0;
        wait(dout_val == 1);
        
        repeat(`N_NUM) begin
            @(posedge clk);
            if(data_out_golden_mem_buf[blk_idx2*`N_NUM + code_idx] != dout || dout_val == 0) begin
                fail = 1;
                $sformat(log_info,"blk_idx2 = [%d]; code_idx = [%d] ",blk_idx2,code_idx);
                `uvm_error( "DEBUG",log_info );
            end
                        
            code_idx++;
        end
        blk_idx2++;
    end
    $display(" write log file...");    
    file=$fopen(test_log_file,"a+");
    $sformat(log_info,"M=%1d;N=%3d;K=%3d;R=%2d;   Result=%s  @%s",`SYM_BW,`N_NUM,K_MSG_LEN,`R_NUM,(fail)? "Fail":"Pass",cur_date_time);
    
    $fdisplay(file,"%s",log_info);
    
    $fclose(file);    
    

 endtask



 



endinterface