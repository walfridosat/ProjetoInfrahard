onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU/clock
add wave -noupdate /CPU/reset
add wave -noupdate /CPU/PCout
add wave -noupdate /CPU/AluA
add wave -noupdate /CPU/AluB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {258 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1 ns}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 20000ps sim:/CPU/clock 
wave create -driver freeze -pattern constant -value HiZ -starttime 0ps -endtime 2000ps sim:/CPU/reset 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 20000ps sim:/CPU/reset 
wave edit invert -start 258ps -end 20000ps Edit:/CPU/reset 
wave edit invert -start 120ps -end 258ps Edit:/CPU/reset 
WaveCollapseAll -1
wave clipboard restore
