onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -radix unsigned /harness/DUT/*
#add wave -noupdate -radix unsigned /harness/DUT/clk
#add wave -noupdate -radix unsigned /harness/DUT/rst_n
#add wave -noupdate -radix unsigned /harness/DUT/din_val
#add wave -noupdate -radix unsigned /harness/DUT/din_sop
#add wave -noupdate -radix unsigned /harness/DUT/din_eop
#add wave -noupdate -radix unsigned /harness/DUT/din
#
#add wave -noupdate -radix unsigned /harness/DUT/sym_width
#add wave -noupdate -radix unsigned /harness/DUT/symb_out_cnt  
#add wave -noupdate -radix unsigned /harness/DUT/symb_out_val  
#add wave -noupdate -radix unsigned /harness/DUT/symb_corrected


#add wave -noupdate -divider err_location
#add wave -noupdate -radix unsigned /harness/DUT/err_loc1
#add wave -noupdate -radix unsigned /harness/DUT/err_loc2
#add wave -noupdate -radix unsigned /harness/DUT/err_loc3
#add wave -noupdate -radix unsigned /harness/DUT/err_loc4
#add wave -noupdate -radix unsigned /harness/DUT/err_loc5
#add wave -noupdate -radix unsigned /harness/DUT/err_loc6
#add wave -noupdate -radix unsigned /harness/DUT/err_loc7
#add wave -noupdate -radix unsigned /harness/DUT/err_loc8
#add wave -noupdate -divider err_value
#add wave -noupdate -radix unsigned /harness/DUT/err_val1
#add wave -noupdate -radix unsigned /harness/DUT/err_val2
#add wave -noupdate -radix unsigned /harness/DUT/err_val3
#add wave -noupdate -radix unsigned /harness/DUT/err_val4
#add wave -noupdate -radix unsigned /harness/DUT/err_val5
#add wave -noupdate -radix unsigned /harness/DUT/err_val6
#add wave -noupdate -radix unsigned /harness/DUT/err_val7
#add wave -noupdate -radix unsigned /harness/DUT/err_val8
#add wave -noupdate -radix unsigned /harness/DUT/error_num
#add wave -noupdate -radix unsigned /harness/DUT/dec_done
#add wave -noupdate -divider syndrome
add wave -noupdate -radix unsigned /harness/DUT/syndrome_val
add wave -noupdate -radix unsigned /harness/DUT/syndrome1
#add wave -noupdate -radix unsigned /harness/DUT/syndrome2
#add wave -noupdate -radix unsigned /harness/DUT/syndrome3
#add wave -noupdate -radix unsigned /harness/DUT/syndrome4
#add wave -noupdate -radix unsigned /harness/DUT/syndrome5
#add wave -noupdate -radix unsigned /harness/DUT/syndrome6
#add wave -noupdate -radix unsigned /harness/DUT/syndrome7
#add wave -noupdate -radix unsigned /harness/DUT/syndrome8
#add wave -noupdate -radix unsigned /harness/DUT/syndrome9
#add wave -noupdate -radix unsigned /harness/DUT/syndrome10
#add wave -noupdate -radix unsigned /harness/DUT/syndrome11
#add wave -noupdate -radix unsigned /harness/DUT/syndrome12
#add wave -noupdate -radix unsigned /harness/DUT/syndrome13
#add wave -noupdate -radix unsigned /harness/DUT/syndrome14
#add wave -noupdate -radix unsigned /harness/DUT/syndrome15
#add wave -noupdate -radix unsigned /harness/DUT/syndrome16
add wave -noupdate -divider KES,lamda
add wave -noupdate -radix unsigned /harness/DUT/lamda
#add wave -noupdate -radix unsigned /harness/DUT/lamda1
#add wave -noupdate -radix unsigned /harness/DUT/lamda2
#add wave -noupdate -radix unsigned /harness/DUT/lamda3
#add wave -noupdate -radix unsigned /harness/DUT/lamda4
#add wave -noupdate -radix unsigned /harness/DUT/lamda5
#add wave -noupdate -radix unsigned /harness/DUT/lamda6
#add wave -noupdate -radix unsigned /harness/DUT/lamda7
#add wave -noupdate -radix unsigned /harness/DUT/lamda8
add wave -noupdate -divider KES,omega
add wave -noupdate -radix unsigned /harness/DUT/omega
#add wave -noupdate -radix unsigned /harness/DUT/omega1
#add wave -noupdate -radix unsigned /harness/DUT/omega2
#add wave -noupdate -radix unsigned /harness/DUT/omega3
#add wave -noupdate -radix unsigned /harness/DUT/omega4
#add wave -noupdate -radix unsigned /harness/DUT/omega5
#add wave -noupdate -radix unsigned /harness/DUT/omega6
#add wave -noupdate -radix unsigned /harness/DUT/omega7
#add wave -noupdate -radix unsigned /harness/DUT/err_val_done
#add wave -noupdate -radix unsigned /harness/DUT/chien_ok
#add wave -noupdate -divider kes_calc
#add wave -noupdate -divider u_err_value
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/clk
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/rst_n
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/start
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/error_num
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda0
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda1
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda2
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda3
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda4
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda5
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda6
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda7
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda8
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega0
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega1
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega2
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega3
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega4
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega5
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega6
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega7
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc1
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc2
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc3
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc4
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc5
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc6
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc7
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc8
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val1
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val2
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val3
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val4
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val5
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val6
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val7
#add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_val8
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/done
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/error_num_d
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda_d
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega_d
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/err_loc_d
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/accu_tb
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/accu_tb1
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/palpha
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/palpha_1
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/byte_cnt
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamdaxalpha
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omegaxalpha
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda_ov
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega_v
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/lamda_ov_inv
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/idx_inv
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/alpha_idx_inv
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omega_vxlamda_ov_inv
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/omegaxlamdaxalpha
add wave -noupdate -color yellow -radix unsigned /harness/DUT/u_err_value/done_pre1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5634409 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {5414918 ps} {5838487 ps}
