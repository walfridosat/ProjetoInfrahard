onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU/clock
add wave -noupdate /CPU/reset
add wave -noupdate -radix unsigned -childformat {{{/CPU/PCout[31]} -radix unsigned} {{/CPU/PCout[30]} -radix unsigned} {{/CPU/PCout[29]} -radix unsigned} {{/CPU/PCout[28]} -radix unsigned} {{/CPU/PCout[27]} -radix unsigned} {{/CPU/PCout[26]} -radix unsigned} {{/CPU/PCout[25]} -radix unsigned} {{/CPU/PCout[24]} -radix unsigned} {{/CPU/PCout[23]} -radix unsigned} {{/CPU/PCout[22]} -radix unsigned} {{/CPU/PCout[21]} -radix unsigned} {{/CPU/PCout[20]} -radix unsigned} {{/CPU/PCout[19]} -radix unsigned} {{/CPU/PCout[18]} -radix unsigned} {{/CPU/PCout[17]} -radix unsigned} {{/CPU/PCout[16]} -radix unsigned} {{/CPU/PCout[15]} -radix unsigned} {{/CPU/PCout[14]} -radix unsigned} {{/CPU/PCout[13]} -radix unsigned} {{/CPU/PCout[12]} -radix unsigned} {{/CPU/PCout[11]} -radix unsigned} {{/CPU/PCout[10]} -radix unsigned} {{/CPU/PCout[9]} -radix unsigned} {{/CPU/PCout[8]} -radix unsigned} {{/CPU/PCout[7]} -radix unsigned} {{/CPU/PCout[6]} -radix unsigned} {{/CPU/PCout[5]} -radix unsigned} {{/CPU/PCout[4]} -radix unsigned} {{/CPU/PCout[3]} -radix unsigned} {{/CPU/PCout[2]} -radix unsigned} {{/CPU/PCout[1]} -radix unsigned} {{/CPU/PCout[0]} -radix unsigned}} -subitemconfig {{/CPU/PCout[31]} {-height 15 -radix unsigned} {/CPU/PCout[30]} {-height 15 -radix unsigned} {/CPU/PCout[29]} {-height 15 -radix unsigned} {/CPU/PCout[28]} {-height 15 -radix unsigned} {/CPU/PCout[27]} {-height 15 -radix unsigned} {/CPU/PCout[26]} {-height 15 -radix unsigned} {/CPU/PCout[25]} {-height 15 -radix unsigned} {/CPU/PCout[24]} {-height 15 -radix unsigned} {/CPU/PCout[23]} {-height 15 -radix unsigned} {/CPU/PCout[22]} {-height 15 -radix unsigned} {/CPU/PCout[21]} {-height 15 -radix unsigned} {/CPU/PCout[20]} {-height 15 -radix unsigned} {/CPU/PCout[19]} {-height 15 -radix unsigned} {/CPU/PCout[18]} {-height 15 -radix unsigned} {/CPU/PCout[17]} {-height 15 -radix unsigned} {/CPU/PCout[16]} {-height 15 -radix unsigned} {/CPU/PCout[15]} {-height 15 -radix unsigned} {/CPU/PCout[14]} {-height 15 -radix unsigned} {/CPU/PCout[13]} {-height 15 -radix unsigned} {/CPU/PCout[12]} {-height 15 -radix unsigned} {/CPU/PCout[11]} {-height 15 -radix unsigned} {/CPU/PCout[10]} {-height 15 -radix unsigned} {/CPU/PCout[9]} {-height 15 -radix unsigned} {/CPU/PCout[8]} {-height 15 -radix unsigned} {/CPU/PCout[7]} {-height 15 -radix unsigned} {/CPU/PCout[6]} {-height 15 -radix unsigned} {/CPU/PCout[5]} {-height 15 -radix unsigned} {/CPU/PCout[4]} {-height 15 -radix unsigned} {/CPU/PCout[3]} {-height 15 -radix unsigned} {/CPU/PCout[2]} {-height 15 -radix unsigned} {/CPU/PCout[1]} {-height 15 -radix unsigned} {/CPU/PCout[0]} {-height 15 -radix unsigned}} /CPU/PCout
add wave -noupdate -radix decimal /CPU/PCin
add wave -noupdate /CPU/PCwrite
add wave -noupdate /CPU/Controle/estado
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg0
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg1
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg2
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg3
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg4
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg5
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg6
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg7
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg8
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg9
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg10
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg11
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg12
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg13
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg14
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg15
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg16
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg17
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg18
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg19
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg20
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg21
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg22
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg23
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg24
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg25
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg26
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg27
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg28
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg29
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg30
add wave -noupdate -group BancoReg -radix decimal /CPU/Banco_regi/Reg31
add wave -noupdate -radix decimal /CPU/Hi/Saida
add wave -noupdate -radix decimal /CPU/Lo/Saida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5922 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 122
configure wave -valuecolwidth 86
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
WaveRestoreZoom {0 ps} {2559 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 20000ps sim:/CPU/clock 
wave create -driver freeze -pattern constant -value HiZ -starttime 0ps -endtime 2000ps sim:/CPU/reset 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 20000ps sim:/CPU/reset 
wave edit invert -start 500ps -end 20000ps Edit:/CPU/reset 
WaveCollapseAll -1
wave clipboard restore