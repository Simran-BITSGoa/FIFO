onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_testbench/write_clk
add wave -noupdate /fifo_testbench/read_clk
add wave -noupdate /fifo_testbench/rst
add wave -noupdate /fifo_testbench/write_en
add wave -noupdate /fifo_testbench/read_en
add wave -noupdate /fifo_testbench/data_in
add wave -noupdate /fifo_testbench/data_out
add wave -noupdate /fifo_testbench/full
add wave -noupdate /fifo_testbench/empty
add wave -noupdate /fifo_testbench/read_str
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {31521 ns}
