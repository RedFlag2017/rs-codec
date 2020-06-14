interface smp_if #(parameter DW = 32) ( 
input logic [DW - 1:0] data  ,
input logic            data_vld  ,
input logic            clk   ,
input logic            rst_n ,
input logic            smp_en,
input string           out_file
);
// logic [DW - 1:0] data ;
// logic            clk  ;
// logic            rst_n;


string log_dut_file; 
integer file;

initial begin
    
    log_dut_file = {"../11_log/",out_file};
    @(negedge rst_n);
    @(posedge rst_n);
    
    wait(smp_en == 1'b1);
    // $display("file name :%s\n",log_dut_file);
    
    file=$fopen(log_dut_file,"w+");
    
    forever begin
        @(posedge clk);
        if(data_vld)
            $fdisplay(file,"%x",data);
    end
    $fclose(file);
end

endinterface