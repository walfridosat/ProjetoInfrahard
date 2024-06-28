onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU/clock
add wave -noupdate /CPU/reset
add wave -noupdate -radix unsigned -childformat {{{/CPU/PCout[31]} -radix unsigned} {{/CPU/PCout[30]} -radix unsigned} {{/CPU/PCout[29]} -radix unsigned} {{/CPU/PCout[28]} -radix unsigned} {{/CPU/PCout[27]} -radix unsigned} {{/CPU/PCout[26]} -radix unsigned} {{/CPU/PCout[25]} -radix unsigned} {{/CPU/PCout[24]} -radix unsigned} {{/CPU/PCout[23]} -radix unsigned} {{/CPU/PCout[22]} -radix unsigned} {{/CPU/PCout[21]} -radix unsigned} {{/CPU/PCout[20]} -radix unsigned} {{/CPU/PCout[19]} -radix unsigned} {{/CPU/PCout[18]} -radix unsigned} {{/CPU/PCout[17]} -radix unsigned} {{/CPU/PCout[16]} -radix unsigned} {{/CPU/PCout[15]} -radix unsigned} {{/CPU/PCout[14]} -radix unsigned} {{/CPU/PCout[13]} -radix unsigned} {{/CPU/PCout[12]} -radix unsigned} {{/CPU/PCout[11]} -radix unsigned} {{/CPU/PCout[10]} -radix unsigned} {{/CPU/PCout[9]} -radix unsigned} {{/CPU/PCout[8]} -radix unsigned} {{/CPU/PCout[7]} -radix unsigned} {{/CPU/PCout[6]} -radix unsigned} {{/CPU/PCout[5]} -radix unsigned} {{/CPU/PCout[4]} -radix unsigned} {{/CPU/PCout[3]} -radix unsigned} {{/CPU/PCout[2]} -radix unsigned} {{/CPU/PCout[1]} -radix unsigned} {{/CPU/PCout[0]} -radix unsigned}} -subitemconfig {{/CPU/PCout[31]} {-height 15 -radix unsigned} {/CPU/PCout[30]} {-height 15 -radix unsigned} {/CPU/PCout[29]} {-height 15 -radix unsigned} {/CPU/PCout[28]} {-height 15 -radix unsigned} {/CPU/PCout[27]} {-height 15 -radix unsigned} {/CPU/PCout[26]} {-height 15 -radix unsigned} {/CPU/PCout[25]} {-height 15 -radix unsigned} {/CPU/PCout[24]} {-height 15 -radix unsigned} {/CPU/PCout[23]} {-height 15 -radix unsigned} {/CPU/PCout[22]} {-height 15 -radix unsigned} {/CPU/PCout[21]} {-height 15 -radix unsigned} {/CPU/PCout[20]} {-height 15 -radix unsigned} {/CPU/PCout[19]} {-height 15 -radix unsigned} {/CPU/PCout[18]} {-height 15 -radix unsigned} {/CPU/PCout[17]} {-height 15 -radix unsigned} {/CPU/PCout[16]} {-height 15 -radix unsigned} {/CPU/PCout[15]} {-height 15 -radix unsigned} {/CPU/PCout[14]} {-height 15 -radix unsigned} {/CPU/PCout[13]} {-height 15 -radix unsigned} {/CPU/PCout[12]} {-height 15 -radix unsigned} {/CPU/PCout[11]} {-height 15 -radix unsigned} {/CPU/PCout[10]} {-height 15 -radix unsigned} {/CPU/PCout[9]} {-height 15 -radix unsigned} {/CPU/PCout[8]} {-height 15 -radix unsigned} {/CPU/PCout[7]} {-height 15 -radix unsigned} {/CPU/PCout[6]} {-height 15 -radix unsigned} {/CPU/PCout[5]} {-height 15 -radix unsigned} {/CPU/PCout[4]} {-height 15 -radix unsigned} {/CPU/PCout[3]} {-height 15 -radix unsigned} {/CPU/PCout[2]} {-height 15 -radix unsigned} {/CPU/PCout[1]} {-height 15 -radix unsigned} {/CPU/PCout[0]} {-height 15 -radix unsigned}} /CPU/PCout
add wave -noupdate /CPU/Controle/estado
add wave -noupdate -expand -group Aluinfo -radix decimal /CPU/AluA
add wave -noupdate -expand -group Aluinfo -radix decimal /CPU/AluB
add wave -noupdate -expand -group Aluinfo -radix decimal -childformat {{{/CPU/AluOut_out[31]} -radix decimal} {{/CPU/AluOut_out[30]} -radix decimal} {{/CPU/AluOut_out[29]} -radix decimal} {{/CPU/AluOut_out[28]} -radix decimal} {{/CPU/AluOut_out[27]} -radix decimal} {{/CPU/AluOut_out[26]} -radix decimal} {{/CPU/AluOut_out[25]} -radix decimal} {{/CPU/AluOut_out[24]} -radix decimal} {{/CPU/AluOut_out[23]} -radix decimal} {{/CPU/AluOut_out[22]} -radix decimal} {{/CPU/AluOut_out[21]} -radix decimal} {{/CPU/AluOut_out[20]} -radix decimal} {{/CPU/AluOut_out[19]} -radix decimal} {{/CPU/AluOut_out[18]} -radix decimal} {{/CPU/AluOut_out[17]} -radix decimal} {{/CPU/AluOut_out[16]} -radix decimal} {{/CPU/AluOut_out[15]} -radix decimal} {{/CPU/AluOut_out[14]} -radix decimal} {{/CPU/AluOut_out[13]} -radix decimal} {{/CPU/AluOut_out[12]} -radix decimal} {{/CPU/AluOut_out[11]} -radix decimal} {{/CPU/AluOut_out[10]} -radix decimal} {{/CPU/AluOut_out[9]} -radix decimal} {{/CPU/AluOut_out[8]} -radix decimal} {{/CPU/AluOut_out[7]} -radix decimal} {{/CPU/AluOut_out[6]} -radix decimal} {{/CPU/AluOut_out[5]} -radix decimal} {{/CPU/AluOut_out[4]} -radix decimal} {{/CPU/AluOut_out[3]} -radix decimal} {{/CPU/AluOut_out[2]} -radix decimal} {{/CPU/AluOut_out[1]} -radix decimal} {{/CPU/AluOut_out[0]} -radix decimal}} -subitemconfig {{/CPU/AluOut_out[31]} {-height 15 -radix decimal} {/CPU/AluOut_out[30]} {-height 15 -radix decimal} {/CPU/AluOut_out[29]} {-height 15 -radix decimal} {/CPU/AluOut_out[28]} {-height 15 -radix decimal} {/CPU/AluOut_out[27]} {-height 15 -radix decimal} {/CPU/AluOut_out[26]} {-height 15 -radix decimal} {/CPU/AluOut_out[25]} {-height 15 -radix decimal} {/CPU/AluOut_out[24]} {-height 15 -radix decimal} {/CPU/AluOut_out[23]} {-height 15 -radix decimal} {/CPU/AluOut_out[22]} {-height 15 -radix decimal} {/CPU/AluOut_out[21]} {-height 15 -radix decimal} {/CPU/AluOut_out[20]} {-height 15 -radix decimal} {/CPU/AluOut_out[19]} {-height 15 -radix decimal} {/CPU/AluOut_out[18]} {-height 15 -radix decimal} {/CPU/AluOut_out[17]} {-height 15 -radix decimal} {/CPU/AluOut_out[16]} {-height 15 -radix decimal} {/CPU/AluOut_out[15]} {-height 15 -radix decimal} {/CPU/AluOut_out[14]} {-height 15 -radix decimal} {/CPU/AluOut_out[13]} {-height 15 -radix decimal} {/CPU/AluOut_out[12]} {-height 15 -radix decimal} {/CPU/AluOut_out[11]} {-height 15 -radix decimal} {/CPU/AluOut_out[10]} {-height 15 -radix decimal} {/CPU/AluOut_out[9]} {-height 15 -radix decimal} {/CPU/AluOut_out[8]} {-height 15 -radix decimal} {/CPU/AluOut_out[7]} {-height 15 -radix decimal} {/CPU/AluOut_out[6]} {-height 15 -radix decimal} {/CPU/AluOut_out[5]} {-height 15 -radix decimal} {/CPU/AluOut_out[4]} {-height 15 -radix decimal} {/CPU/AluOut_out[3]} {-height 15 -radix decimal} {/CPU/AluOut_out[2]} {-height 15 -radix decimal} {/CPU/AluOut_out[1]} {-height 15 -radix decimal} {/CPU/AluOut_out[0]} {-height 15 -radix decimal}} /CPU/AluOut_out
add wave -noupdate -expand -group Aluinfo -radix decimal /CPU/AluOutRg/Entrada
add wave -noupdate -expand -group Aluinfo -radix decimal /CPU/AluOutRg/Saida
add wave -noupdate -expand -group Aluinfo /CPU/AluOutRg/Load
add wave -noupdate -expand -group PC -radix decimal /CPU/PC/Entrada
add wave -noupdate -expand -group PC /CPU/PC/Load
add wave -noupdate -expand -group PC -radix decimal /CPU/PC/Saida
add wave -noupdate -group LoadInfo -radix decimal /CPU/PCwrite
add wave -noupdate -group LoadInfo /CPU/IRWrite
add wave -noupdate -group LoadInfo /CPU/AluOutLoad
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
add wave -noupdate -radix decimal -childformat {{{/CPU/ConditinHandler/out[0]} -radix decimal}} -subitemconfig {{/CPU/ConditinHandler/out[0]} {-height 15 -radix decimal}} /CPU/ConditinHandler/out
add wave -noupdate -expand -group ToALuA -radix decimal /CPU/AtoAlu/sel
add wave -noupdate -expand -group ToALuA -radix decimal /CPU/AtoAlu/pc
add wave -noupdate -expand -group ToALuA -radix decimal /CPU/AtoAlu/a
add wave -noupdate -expand -group ToALuA -radix decimal /CPU/AtoAlu/out
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/sel
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/b
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/sign_extend
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/sign_extend_sl2
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/memorydataregister
add wave -noupdate -expand -group ToAluB -radix decimal /CPU/BtoAlu/out
add wave -noupdate -group Conditions /CPU/LT_ula
add wave -noupdate -group Conditions /CPU/EQ_cmp
add wave -noupdate -group Conditions /CPU/CHOut
add wave -noupdate -group Conditions /CPU/condType
add wave -noupdate -group Conditions /CPU/ConditinHandler/EQ
add wave -noupdate -group Conditions /CPU/ConditinHandler/GT
add wave -noupdate -group Conditions /CPU/ConditinHandler/LE
add wave -noupdate -group Conditions /CPU/ConditinHandler/NE
add wave -noupdate -group Shift2 -radix decimal /CPU/ShiftFromExtender/data
add wave -noupdate -group Shift2 -radix decimal -childformat {{{/CPU/ShiftFromExtender/out[31]} -radix decimal} {{/CPU/ShiftFromExtender/out[30]} -radix decimal} {{/CPU/ShiftFromExtender/out[29]} -radix decimal} {{/CPU/ShiftFromExtender/out[28]} -radix decimal} {{/CPU/ShiftFromExtender/out[27]} -radix decimal} {{/CPU/ShiftFromExtender/out[26]} -radix decimal} {{/CPU/ShiftFromExtender/out[25]} -radix decimal} {{/CPU/ShiftFromExtender/out[24]} -radix decimal} {{/CPU/ShiftFromExtender/out[23]} -radix decimal} {{/CPU/ShiftFromExtender/out[22]} -radix decimal} {{/CPU/ShiftFromExtender/out[21]} -radix decimal} {{/CPU/ShiftFromExtender/out[20]} -radix decimal} {{/CPU/ShiftFromExtender/out[19]} -radix decimal} {{/CPU/ShiftFromExtender/out[18]} -radix decimal} {{/CPU/ShiftFromExtender/out[17]} -radix decimal} {{/CPU/ShiftFromExtender/out[16]} -radix decimal} {{/CPU/ShiftFromExtender/out[15]} -radix decimal} {{/CPU/ShiftFromExtender/out[14]} -radix decimal} {{/CPU/ShiftFromExtender/out[13]} -radix decimal} {{/CPU/ShiftFromExtender/out[12]} -radix decimal} {{/CPU/ShiftFromExtender/out[11]} -radix decimal} {{/CPU/ShiftFromExtender/out[10]} -radix decimal} {{/CPU/ShiftFromExtender/out[9]} -radix decimal} {{/CPU/ShiftFromExtender/out[8]} -radix decimal} {{/CPU/ShiftFromExtender/out[7]} -radix decimal} {{/CPU/ShiftFromExtender/out[6]} -radix decimal} {{/CPU/ShiftFromExtender/out[5]} -radix decimal} {{/CPU/ShiftFromExtender/out[4]} -radix decimal} {{/CPU/ShiftFromExtender/out[3]} -radix decimal} {{/CPU/ShiftFromExtender/out[2]} -radix decimal} {{/CPU/ShiftFromExtender/out[1]} -radix decimal} {{/CPU/ShiftFromExtender/out[0]} -radix decimal}} -subitemconfig {{/CPU/ShiftFromExtender/out[31]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[30]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[29]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[28]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[27]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[26]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[25]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[24]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[23]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[22]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[21]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[20]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[19]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[18]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[17]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[16]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[15]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[14]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[13]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[12]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[11]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[10]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[9]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[8]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[7]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[6]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[5]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[4]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[3]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[2]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[1]} {-height 15 -radix decimal} {/CPU/ShiftFromExtender/out[0]} {-height 15 -radix decimal}} /CPU/ShiftFromExtender/out
add wave -noupdate -group ToAluOut -radix decimal /CPU/toAluOut/LT
add wave -noupdate -group ToAluOut -radix decimal /CPU/toAluOut/out
add wave -noupdate -group ToAluOut -radix decimal /CPU/toAluOut/shiftOut
add wave -noupdate -group ToAluOut /CPU/toAluOut/SrcOut
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/Entrada
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/N
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/n_shift
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/Reset
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/Saida
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/Shift
add wave -noupdate -group Desloc -radix decimal /CPU/Desloc/temp
add wave -noupdate -radix decimal /CPU/Addr_Memo
add wave -noupdate /CPU/Instruc_Reg/Load_ir
add wave -noupdate /CPU/Instruc_Reg/Instr31_26
add wave -noupdate /CPU/Instruc_Reg/Instr25_21
add wave -noupdate /CPU/Instruc_Reg/Instr20_16
add wave -noupdate /CPU/Instruc_Reg/Instr15_0
add wave -noupdate /CPU/OrCmpnt/A
add wave -noupdate /CPU/OrCmpnt/B
add wave -noupdate /CPU/OrCmpnt/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21935 ps} 0} {{Edit Cursor} {2146 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 122
configure wave -valuecolwidth 74
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
WaveRestoreZoom {0 ps} {2607 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 20000ps sim:/CPU/clock 
wave create -driver freeze -pattern constant -value HiZ -starttime 0ps -endtime 2000ps sim:/CPU/reset 
wave create -driver freeze -pattern clock -initialvalue St1 -period 100ps -dutycycle 50 -starttime 0ps -endtime 30000ps sim:/CPU/clock 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 20000ps sim:/CPU/reset 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 30000ps sim:/CPU/reset 
wave edit invert -start 151ps -end 30000ps Edit:/CPU/reset 
WaveCollapseAll -1
wave clipboard restore
