import os
import shutil
import datetime


def gen_do_file( cur_time ):
   # 打开一个文件
   fo = open("sim_dec.do", "w+")
   
   
   fo.write("set UVM_DPI_HOME C:/modeltech_10.2c/uvm-1.1d/win32\n")
   fo.write("set TEST_NAME case1\n")
   
   fo.write("vlib novas\n")
   fo.write("vmap novas novas\n")
   fo.write("vlog -work novas C:/Novas/Debussy/share/PLI/modelsim_pli/WINNT/novas_vlog.v\n")
   
   fo.write("vlib work\n")
   
   fo.write("vlog -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  +incdir+../00_src/rs_dec/+../03_tb/ -f ../00_src/rs_dec/src.lst ../03_tb/harness.sv\n")
   
   fo.write("vsim -sv_lib $UVM_DPI_HOME/uvm_dpi  -pli novas.dll -novopt work.harness +SYS_DATE_TIME=" + cur_time + " +UVM_TESTNAME=$TEST_NAME +UVM_VERBOSITY=UVM_MEDIUM \n")
   
   fo.write("do ../02_script/wave_dec.do\n")
   
   fo.write("run -all\n")
   
   fo.write("quit  \n ") 
   
   
   fo.close()
   return 1

   
def gen_cfg_file( blk_n,m,n_s,r ):
   # 打开一个文件
   fo     = open("../03_tb/alg_rm/rs_dec_cfg.m", "w+")
   fo_svh = open("../03_tb/rs_dec_cfg.svh", "w+")
   
   
   fo.write("blk_n = " + str(blk_n )+ "\n")
   fo_svh.write("`define BLK_NUM    " + str(blk_n) + '\n');
   
   fo.write("m = "     + str(m )+ "\n")
   fo_svh.write("`define SYM_BW    " + str(m) + '\n');
   
   fo.write("n_s = "     + str(n_s )+ "\n")
   fo_svh.write("`define N_NUM    " + str(n_s) + '\n');
   
   fo.write("r = "     + str(r )+ "\n")  
   fo_svh.write("`define R_NUM    " + str(r) + '\n');
   
   fo.close()   
   fo_svh.close()
   
   return 1   


   
blk_n = 3
batch_mode =  0 # 0: run 1 case ;1: batch mode ,run all case

if batch_mode == 0:
    # r_dict = {'8':[16]} ## m:r
    # n_dict = {'8':[204]} ## m:n
    # r_dict = {'3':[4]} ## m:r
    # n_dict = {'3':[7]} ## m:n
    r_dict = {'4':[4]} ## m:r
    n_dict = {'4':[15]} ## m:n   
    # r_dict = {'5':[8]} ## m:r
    # n_dict = {'5':[31]} ## m:n   
    # r_dict = {'6':[8]} ## m:r
    # n_dict = {'6':[63]} ## m:n   
    # r_dict = {'7':[8]} ## m:r
    # n_dict = {'7':[127]} ## m:n 
      
else:
    # r_dict = {
    # '3':[2, 4],
    # '4':[2, 4 ,8],
    # '5':[2, 4 ,8 ,16 ],
    # '6':[2, 4 ,8 ,16 ,32],
    # '7':[2, 4 ,8 ,16 ,32],
    # '8':[2, 4 ,8 ,16 ,32]
    # }
    # n_dict = {
    # '3':[5  , 7],
    # '4':[11 ,15],
    # '5':[28 ,31 ],
    # '6':[50 ,63],
    # '7':[102,127],
    # '8':[204,255]
    # }
    # r_dict = {
    # '3':[2, 4],
    # '4':[2, 8],
    # '5':[2  ],
    # '6':[2, 32],
    # '7':[2, 32],
    # '8':[2, 32]
    # }
    # n_dict = {
    # '3':[5  , 7],
    # '4':[11 ,15],
    # '5':[28 ,31 ],
    # '6':[50 ,63],
    # '7':[102,127],
    # '8':[204,255]
    # }    
    r_dict = {
    '3':[4 ],
    '4':[4 ],
    '5':[8 ],
    '6':[8 ],
    '7':[16 ],
    '8':[32 ]
    }
    n_dict = {
    '3':[ 7 ],
    '4':[15 ],
    '5':[31 ],
    '6':[63 ],
    '7':[127],
    '8':[255]
    }    


    

for m_key in r_dict.keys():
    print("m_key="+ str(m_key))    
    # for i in (r_dict.get(m)):
    for r_key in (r_dict[m_key]):
        print("   r_key=" + str(r_key))
        
        m = int(m_key);
        r = int(r_key);
        for n_key in (n_dict[m_key]):
            n_s = int(n_key);
            print('m   = ' + str(m))
            print('n_s = ' + str(n_s))
            print('r   = ' + str(r))
            
       
            gen_cfg_file( blk_n = blk_n,m=m,n_s=n_s,r=r )

            # input()   
            cur_time = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S')  
            gen_do_file( cur_time )  #in 02_script dir

            debussy = "C:\\Novas\\Debussy\\bin\\Debussy.exe "
            vsim = "C:\\modeltech_10.2c\\win32\\vsim.exe "

            print("exec MATLAB...")
            
            os.chdir("../03_tb/alg_rm/")   #修改当前工作目录
            

            # os.system("matlab -wait -nosplash -r rs_en_dec_test")
            os.system("matlab -wait -nodesktop -nosplash -r rs_en_dec_test")
            os.chdir("../../")   #修改当前工作目录
            

            if os.path.exists("10_sim"):
                shutil.rmtree("10_sim")    #递归删除文件夹
            if os.path.exists("11_log"):    
                shutil.rmtree("11_log")    #递归删除文件夹

            os.mkdir("10_sim/")

            os.makedirs('11_log/DUT_dec')
            os.makedirs('11_log/RM_dec')

            print("echo create log dir done...")    #获取当前工作目录

            os.chdir("./10_sim/")   #修改当前工作目录
            # print(os.getcwd())    #获取当前工作目录

            os.system(vsim + "-c -do ../02_script/sim_dec.do")
            

            # os.system(debussy + " -f ../00_src/src.lst -ssf wave.fsdb -2001")
            
