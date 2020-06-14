set UVM_DPI_HOME C:/modeltech_10.2c/uvm-1.1d/win32
set TEST_NAME case1
vlib novas
vmap novas novas
vlog -work novas C:/Novas/Debussy/share/PLI/modelsim_pli/WINNT/novas_vlog.v
vlib work
vlog -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  +incdir+../00_src/rs_dec/+../03_tb/ -f ../00_src/rs_dec/src.lst ../03_tb/harness.sv
vsim -sv_lib $UVM_DPI_HOME/uvm_dpi  -pli novas.dll -novopt work.harness +SYS_DATE_TIME=2020-06-14-15-01-35 +UVM_TESTNAME=$TEST_NAME +UVM_VERBOSITY=UVM_MEDIUM 
do ../02_script/wave_dec.do
run -all
quit  
 