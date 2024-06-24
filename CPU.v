// procure por !!! para encontrar possíveis problemas / observações importantes
module CPU (
    input wire clock,
    input wire reset
);
/////////////////////
////    wires    ////
/////////////////////

// Instructions
wire [5:0]  Instr31_26; 
wire [4:0]  Instr25_21;
wire [4:0]  Instr20_16;
wire [15:0] Instr15_0;
wire [25:0] Instr25_0; //
wire [4:0]  Instr15_11;//
wire [5:0]  Instr5_0;   //
wire [4:0]  Instr10_6;
assign Instr25_0  = {Instr25_21, Instr20_16, Instr15_0};
assign Instr15_11 = Instr15_0[15:11];
assign Instr5_0   = Instr15_0[5:0];
assign Instr10_6  = Instr15_0[10:6];
 
// Banco de Reg out
wire [31:0] ReadDataA;
wire [31:0] ReadDataB;
wire [31:0] RegA_out;
wire [31:0] RegB_out;
wire [31:0] AluA;
wire [31:0] AluB;
wire [4:0] RegB4_0;
assign RegB4_0 = RegB_out[4:0];

// PC
wire [31:0] PCout;
wire [31:0] PCin;  //from toPCnxt
wire [3:0]  PChead; 
wire [2:0]  PCSource;
wire PCwrite;
wire PCwriteCond;
wire PCload; //assign
assign PChead = PCout[31:28];


// Others
wire ALWAYS1;
wire IRWrite; //instruction register load
wire RegWrite; //Banco Reg write
wire WriteMemo;
wire [31:0] MemoOut;
wire [31:0] ExceptionAdres; //From opcodes To Mux toWriteData
wire [31:0] ExtendedIntruct;
wire [31:0] Shifted2Intruct;
wire [2:0]  ShiftType;

// Alu Wires v
wire [31:0] AluMuxOut;
wire [31:0] UlaResult;
wire [31:0] OrResult;
wire [31:0] Desloc_out;
wire [31:0] LT_extended;

wire HiLoLoad;
wire [31:0] HiDiv;
wire [31:0] HiMul;
wire [31:0] Hi2Reg;
wire [31:0] HiOut;
wire [31:0] LoDiv;
wire [31:0] LoMul;
wire [31:0] Lo2Reg;
wire [31:0] LoOut;

wire LT_ula;
wire EQ_cmp; 
wire NE_cmp; assign NE_cmp = ~EQ_cmp;
wire LE_cmp; assign LE_cmp =  EQ_cmp | LT_ula;
wire GT_cmp; assign GT_cmp = ~LE_cmp;

wire [4:0] controlType;
wire [1:0] condType;
wire [2:0] ALUOp;
wire [2:0] SrcOut;
wire divOp;
wire multOp;
wire overflowOp;
wire orOp;    // não está sendo utilizado
wire StoreMD; // não está sendo utilizado

wire overflowAlu;
wire overflowflag; 
wire divby0flag;
// alu wires ^

// RegWires
wire [31:0] AluOut_out;
wire [31:0] AluOut_in;
wire SaveTemp; //load
wire EPCWrite;//load
wire AluOutLoad; //load
wire [31:0] EPC_out;
wire [31:0] EPC_in; // !!! vem de onde? 
wire [31:0] temp_out;
wire [31:0] MemoDataReg_out;

// Mux outputs
wire CHOut; //condition handler out
wire [31:0] IorD_Out;
wire [31:0] Addr_Memo;
wire [31:0] SizeHandler_out;
wire [31:0] toWriteMemo_out;
wire [31:0] mxToWriteData;
wire [4:0]  mxToWriteRegi;
wire [31:0] sllA_out;
wire [4:0]  sllB_out;
wire [31:0] jumpAdress;

// Mux Selects
wire [0:0] IorDSel;
wire [0:0] DataSource;
wire [2:0] SrcAddr;
wire [2:0] SzHndlrSel;
wire [1:0] RegDest;
wire [2:0] MemToReg;
wire [0:0] ALUSrcA;
wire [2:0] ALUSrcB;
wire [1:0] SLLSourceA;
wire [1:0] SLLSourceB;


assign overflowflag = overflowAlu & overflowOp;
assign PCload = PCwrite | (PCwriteCond & CHOut);
assign HiLoLoad = divOp | multOp;
assign ALWAYS1 = 1'b1; /// !!! Cuidado !!! Alguns regs talvez realmente precisem de um Load definido
assign EPC_in = mxToWriteData;


/////////////////////
//// componentes ////
/////////////////////

// Controle //
opcodelogic Controle (
    .opcode(Instr31_26),
    .funct(Instr5_0),
    .overflowflag(overflowflag),
    .divby0flag(divby0flag),
    .clk(clock),
    .reset(reset),

    .PCWriteCond(PCwriteCond),
    .PCWrite(PCwrite),
    .IorD(IorDSel),
    .SrcAddr(SrcAddr),
    .WR(WriteMemo),
    .ResetTrigger(),    //wire [0:0] ResetTrigger; // não necessário?
    .SaveTemp(SaveTemp),
    .MemToReg(MemToReg),
    .SizeHandler(SzHndlrSel),
    .IRWrite(IRWrite),
    .ExceptionAdress(ExceptionAdress),
    .DataSource(DataSource),
    .EPCWrite(EPCWrite),
    .RegDest(RegDest),
    .RegWrite(RegWrite),
    .AluOutLoad(),    // !!! Adicionado agora!!! Precisa colocar no Opcode
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ControlType(controlType),
    .PCSource(PCSource),
    .SLLSourceA(SLLSourceA),
    .SLLSourceB(SLLSourceB),
    .ShiftType(ShiftType)
); 



// Principais
Memoria     Memory   (.Clock(clock), .Address(Addr_Memo), .Wr(WriteMemo), .Datain(toWriteMemo_out), .Dataout(MemoOut));
Registrador PC         (.Clk(clock), .Reset(reset), .Load(PCload), .Entrada(PCin), .Saida(PCout));
Banco_reg   Banco_regi (.Clk(clock), .Reset(reset), .RegWrite(RegWrite), .ReadReg1(Instr25_21), .ReadReg2(Instr20_16), .WriteReg(mxToWriteRegi), .WriteData(mxToWriteData), .ReadData1(ReadDataA), .ReadData2(ReadDataB) );
Instr_Reg   Instruc_Reg(.Clk(clock), .Reset(reset), .Load_ir(IRWrite), .Entrada(MemoOut), .Instr31_26(Instr31_26), .Instr25_21(Instr25_21), .Instr20_16(Instr20_16), .Instr15_0(Instr15_0));


// Operações 
ALUControl    AluCtrl(.controlType(controlType),  .condType(condType), .divOp(divOp), .multOp(multOp), .ALUOp(ALUOp), .orOp(orOp), .overflowOp(overflowOp), .SrcOut(SrcOut), .StoreMD(StoreMD), .ALUOutSave(AluOutLoad));
Ula32         ULA (.A(AluA), .B(AluB), .Seletor(ALUOp), .S(UlaResult), .Overflow(overflowAlu), .Negativo(), .z(), .Igual(EQ_cmp), .Maior(), .Menor(LT_ula));
divisor       Divisor(.clk(clock), .divOp (divOp ), .dividend    (AluA), .divisor   (AluB), .div_hi (HiDiv), .div_lo (LoDiv), .divby0flag(divby0flag)); // !!! atenção com o divisor - alterações no modulo
multiplicador Multip (.clk(clock), .multOp(multOp), .multiplicand(AluA), .multiplier(AluB), .mult_hi(HiMul), .mult_lo(LoMul)); // !!! Multiplicador alterado
RegDesloc     Desloc (.Clk(clock), .Reset(reset),   .Shift(ShiftType),   .N(sllB_out),      .Entrada(sllA_out), .Saida(Desloc_out));
Or            OrCmpnt(.A(AluA), .B(AluB), .result(OrResult));



// Registradores
Registrador A       (.Clk(clock), .Reset(reset), .Load(ALWAYS1),   .Entrada(ReadDataA), .Saida(RegA_out)  );
Registrador B       (.Clk(clock), .Reset(reset), .Load(ALWAYS1),   .Entrada(ReadDataB), .Saida(RegB_out)  );
Registrador Hi      (.Clk(clock), .Reset(reset), .Load(HiLoLoad),  .Entrada(Hi2Reg),    .Saida(HiOut)     );
Registrador Lo      (.Clk(clock), .Reset(reset), .Load(HiLoLoad),  .Entrada(Lo2Reg),    .Saida(LoOut)     );
Registrador AluOutRg(.Clk(clock), .Reset(reset), .Load(AluOutLoad),.Entrada(AluOut_in), .Saida(AluOut_out)); // !!! faltando o LOAD
Registrador EPC     (.Clk(clock), .Reset(reset), .Load(EPCWrite),  .Entrada(EPC_in),    .Saida(EPC_out)   );
Registrador Temp    (.Clk(clock), .Reset(reset), .Load(SaveTemp),  .Entrada(SizeHandler_out), .Saida(temp_out) ); //relacionado ao sizehandler
Registrador MemoData(.Clk(clock), .Reset(reset), .Load(ALWAYS1),   .Entrada(SizeHandler_out), .Saida(MemoDataReg_out) ); //relacionado ao sizehandler


// Mux
aluSrcAMUX  AtoAlu(.sel(ALUSrcA), .out(AluA), .a(RegA_out), .pc(PCout));
aluSrcBMUX  BtoAlu(.sel(ALUSrcB), .out(AluB), .b(RegB_out), .sign_extend(ExtendedIntruct), .sign_extend_sl2(Shifted2Intruct), .memorydataregister(MemoDataReg_out));
MUX32       DMtoHi(.sel(divOp), .A(HiMul), .B(HiDiv), .out(Hi2Reg));
MUX32       DMtoLo(.sel(divOp), .A(LoMul), .B(LoDiv), .out(Lo2Reg));

MUXIorD        PC_Mux2Mux  (.sel(IorDSel),    .out(IorD_Out),        .AluOut(AluOut_out), .PC(PCout));   //Seleciona entre PC e aluOut e manda pra MuxAddr_Memo
SrcAddrMUX     MuxAddr_Memo(.sel(SrcAddr),    .out(Addr_Memo),       .IorD_out(IorD_Out), .A(ReadDataA), .B(ReadDataB)); //Seleciona entre "PC", endereços padrão, ou A/B
regDestMUX     toWriteRegi (.sel(RegDest),    .out(mxToWriteRegi),   .rt(Instr20_16),     .rd(Instr15_11));
memToRegMUX    toWriteData (.sel(MemToReg),   .out(mxToWriteData),   .AluOut(AluOut_out), .memorydataregister(MemoDataReg_out), .exceptionadress(ExceptionAdres), .pc(PCout));
MUXDataSrc     toWriteMemo (.sel(DataSource), .out(toWriteMemo_out), .temp(temp_out),     .size_handler(SizeHandler_out));
sizehandlerMUX SizeHandler (.sel(SzHndlrSel), .out(SizeHandler_out), .mem(MemoOut),       .B(RegB_out));

SrcOutMUX   toAluOut (.SrcOut(SrcOut),  .out(AluOut_in), .Lo(LoOut), .Hi(HiOut), .LT(LT_extended), .result(UlaResult), .orOut(orOut), .shiftOut(Desloc_out));
pcSourceMUX toPCnxt  (.sel(PCSource),   .out(PCin),  .jumpAdress(jumpAdress), .aluOut(AluOut_out), .result(UlaResult), .memData(MemoDataReg_out), .EPCReg(EPC_out));  //Seleciona próximo endereço do PC
sllsrcAMUX  toDeslocA(.sel(SLLSourceA), .out(sllA_out), .A(RegA_out), .B(RegB_out), .imediato(ExtendedIntruct));
sllsrcBMUX  toDeslocB(.sel(SLLSourceB), .out(sllB_out), .B(RegB4_0), .Instruction(Instr10_6));
conditionHandlerMUX ConditinHandler(.sel(condType), .out(CHOut), .NE(NE_cmp), .EQ(EQ_cmp), .LE(LE_cmp), .GT(GT_cmp));


// SignExtender and Shifters
sign_extender16_32 SignExt16_32   (.data(Instr15_0), .data_extended(ExtendedIntruct));
sign_extender1_32  Extend_UlaLT   (.data(LT_ula),    .data_extended(LT_extended));
ShiftLeftTwoSign ShiftFromExtender(.data(ExtendedIntruct), .out(Shifted2Intruct));
ShiftLeftTwoJump ShiftFromJump    (.Instruction(Instr25_0), .PC(PChead), .out(jumpAdress), .y());

endmodule