onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_kc85_4_tb/simulation_run
add wave -noupdate /top_kc85_4_tb/tb_vcot
add wave -noupdate /top_kc85_4_tb/tb_pal_clock
add wave -noupdate /top_kc85_4_tb/tb_reset_button_n
add wave -noupdate /top_kc85_4_tb/tb_led
add wave -noupdate -divider DUT
add wave -noupdate /top_kc85_4_tb/dut/m(2)
add wave -noupdate -radix unsigned -childformat {{/top_kc85_4_tb/dut/h(5) -radix unsigned} {/top_kc85_4_tb/dut/h(4) -radix unsigned} {/top_kc85_4_tb/dut/h(3) -radix unsigned} {/top_kc85_4_tb/dut/h(2) -radix unsigned} {/top_kc85_4_tb/dut/h(1) -radix unsigned} {/top_kc85_4_tb/dut/h(0) -radix unsigned}} -expand -subitemconfig {/top_kc85_4_tb/dut/h(5) {-height 16 -radix unsigned} /top_kc85_4_tb/dut/h(4) {-height 16 -radix unsigned} /top_kc85_4_tb/dut/h(3) {-height 16 -radix unsigned} /top_kc85_4_tb/dut/h(2) {-height 16 -radix unsigned} /top_kc85_4_tb/dut/h(1) {-height 16 -radix unsigned} /top_kc85_4_tb/dut/h(0) {-height 16 -radix unsigned}} /top_kc85_4_tb/dut/h
add wave -noupdate -format Analog-Step -height 84 -max 255.0 -radix unsigned /top_kc85_4_tb/dut/v
add wave -noupdate /top_kc85_4_tb/dut/vzr
add wave -noupdate -divider {m counter}
add wave -noupdate /top_kc85_4_tb/dut/vcot_n
add wave -noupdate /top_kc85_4_tb/dut/hzr
add wave -noupdate /top_kc85_4_tb/dut/m(0)
add wave -noupdate /top_kc85_4_tb/dut/d3401_uv_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1863053088 ps} 0} {{Cursor 3} {1783184232 ps} 0}
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
WaveRestoreZoom {0 ps} {333216432 ps}
