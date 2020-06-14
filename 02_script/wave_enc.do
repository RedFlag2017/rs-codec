onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -radix unsigned /harness_enc/DUT/*

add wave -noupdate -divider u_rs_lfsr
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr8/*
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr7/*
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr6/*
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr5/*
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr4/*
add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr3/*



#add wave -noupdate -divider mul_blk0
#add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr/mul_blk0/*
#add wave -noupdate -divider mul_blk1
#add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr/mul_blk1/*
#add wave -noupdate -divider mul_blk2
#add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr/mul_blk2/*
#add wave -noupdate -divider mul_blk3
#add wave -noupdate -radix unsigned /harness_enc/DUT/u_rs_lfsr/mul_blk3/*




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
