set UVM_DPI_HOME C:/modeltech_10.2c/uvm-1.1d/win32
set TEST_NAME case1
vlib novas
vmap novas novas
vlog -work novas C:/Novas/Debussy/share/PLI/modelsim_pli/WINNT/novas_vlog.v
vlib work
vlog -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  +incdir+../00_src/rs_enc/+../03_tb/ -f ../00_src/rs_enc/src_enc.lst ../03_tb/harness_enc.sv
vsim -sv_lib $UVM_DPI_HOME/uvm_dpi  -pli novas.dll -novopt work.harness_enc +SYS_DATE_TIME=2020-06-14-15-00-15 +UVM_TESTNAME=$TEST_NAME +UVM_VERBOSITY=UVM_MEDIUM 
do ../02_script/wave_enc.do
run -all
quit  
 