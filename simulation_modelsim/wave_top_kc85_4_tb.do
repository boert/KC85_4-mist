onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_kc85_4_tb/simulation_run
add wave -noupdate /top_kc85_4_tb/tb_vcot
add wave -noupdate /top_kc85_4_tb/tb_pal_clock
add wave -noupdate /top_kc85_4_tb/tb_reset_button_n
add wave -noupdate /top_kc85_4_tb/tb_led
add wave -noupdate -divider DUT
add wave -noupdate -expand /top_kc85_4_tb/dut/m
add wave -noupdate -format Analog-Step -height 84 -max 56.0 -radix unsigned /top_kc85_4_tb/dut/h
add wave -noupdate /top_kc85_4_tb/dut/hzr
add wave -noupdate -format Analog-Step -height 84 -max 255.0 -radix unsigned /top_kc85_4_tb/dut/v
add wave -noupdate /top_kc85_4_tb/dut/vzr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {198060040 ps} 0} {{Cursor 2} {251768848 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 236
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {4647139882 ps}
