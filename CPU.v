// procure por !!! para encontrar possíveis problemas / observações importantes
module CPU (
    input wire clock,
    input wire reset
);
/////////////////////
////    wires    ////
/////////////////////

// PC
wire [31:0] PCout;
wire [31:0] PCin;  //from toPCnxt
wire PCwrite;
wire PCwriteCond;
wire PCload; //assign

// RegWires
wire AluOut_out;
wire AluOut_in;

// Mux outputs
wire CHOut; //condition handler out
wire IorDOut;

// Mux Selects
wire IorDSel;

// editando...
wire [5:0] opcode;
wire [5:0] funct;
wire overflowflag;
wire divby0flag;

wire [2:0] SrcAddr;
wire [2:0] SrcOut;
wire [0:0] WR;
wire [0:0] ResetTrigger;
wire [0:0] SaveTemp;
wire [2:0] MemToReg;
wire [2:0] SizeHandler;
wire [0:0] IRWrite;
wire [0:0] ExceptinAdress;
wire [0:0] DataSource;
wire [0:0] EPCWrite;
wire [1:0] RegDest;
wire [0:0] RegWrite;
wire [0:0] ALUSrcA;
wire [2:0] ALUSrcB;
wire [4:0] ControlType;
wire [2:0] PCSource;
wire [1:0] SLLSourceA;
wire [1:0] SLLSourceB;
wire [2:0] ShiftType;

/// Assigns //
assign PCload = PCwrite | (PCwriteCond & CHOut);


/////////////////////
//// componentes ////
/////////////////////

// Controle //
opcodelogic Controle (
    .opcode(),
    .funct(),
    .overflowflag(),
    .divby0flag(),
    .clk(clk),

    .PCWriteCond(),
    .PCWrite(),
    .IorD(IorDSel),
    .SrcAddr(),
    .SrcOut(),
    .WR(),
    .ResetTrigger(),
    .SaveTemp(),
    .MemToReg(),
    .SizeHandler(),
    .IRWrite(),
    .ExceptionAdress(),
    .DataSource(),
    .EPCWrite(),
    .RegDest(),
    .RegWrite(),
    .ALUSrcA(),
    .ALUSrcB(),
    .ControlType(),
    .PCSource(),
    .SLLSourceA(),
    .SLLSourceB(),
    .ShiftType()
); 



// Principais
Memoria     Memory();
Registrador PC(.Clock(clock), .Reset(reset), .Load(), .Entrada(PCin), .Saida(PCout));
Banco_reg   Banco_regi();
Instr_Reg   Instruction_Reg();


// Operações 
ula32         ULA ();
divisor       Divisor();
multiplicador Multip();
ALUControl    AluCtrl();
Or            OrOp();
RegDesloc     Desloc();

// Registradores
Registrador A       (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );
Registrador B       (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );
Registrador Hi      (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );
Registrador Lo      (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );
Registrador AluOutRg(.Clock(clock), .Reset(reset), .Load(), .Entrada(AluOut_in), .Saida(AluOut_out)); //!!!faltando o LOAD
Registrador EPC     (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );
Registrador Temp    (.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() );     //relacionado ao sizehandler
Registrador MemoData(.Clock(clock), .Reset(reset), .Load(), .Entrada(), .Saida() ); //relacionado ao sizehandler


// Mux
aluSrcAMUX  AtoAlu();
aluSrcBMUX  BtoAlu();

MUXIorD     PC_Mux2Mux(.sel(IorDSel), .PC(PCout), .AluOut(AluOut), .out(IorDOut));   //Seleciona entre PC e aluOut e manda pra MuxAddr_Memo
SrcAddrMUX  MuxAddr_Memo(); //Seleciona entre "PC", endereços padrão e A/B
MUXDataSrc  toWriteMemo();
regDestMUX  toWriteRegi();
memToRegMUX toWriteData();
sizehandlerMUX SizeHandler();

SrcOutMUX   toAluOut();
pcSourceMUX toPCnxt();  //Seleciona próximo endereço do PC
sllsrcAMUX toDeslocA();
sllsrcBMUX toDeslocB();
conditionHandlerMUX ConditinHandler(.out(CHOut));


endmodule