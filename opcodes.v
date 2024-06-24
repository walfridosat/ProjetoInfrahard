module opcodelogic (
    input wire [5:0] opcode,
    input wire [5:0] funct,
    input wire overflowflag,
    input wire divby0flag,
    input wire clk,
    input wire reset,

    output reg [0:0] PCWriteCond,
    output reg [0:0] PCWrite,
    output reg [0:0] IorD,
    output reg [2:0] SrcAddr,
    output reg [0:0] WR,
    output reg [0:0] ResetTrigger,
    output reg [0:0] SaveTemp,
    output reg [2:0] MemToReg,
    output reg [2:0] SizeHandler,
    output reg [0:0] IRWrite,
    output reg [31:0] ExceptionAdress,
    output reg [0:0] DataSource,
    output reg [0:0] EPCWrite,
    output reg [1:0] RegDest,
    output reg [0:0] RegWrite,
    output reg [0:0] ALUSrcA,
    output reg [2:0] ALUSrcB,
    output reg [0:0] AluOutLoad,
    output reg [4:0] ControlType,
    output reg [2:0] PCSource,
    output reg [1:0] SLLSourceA,
    output reg [1:0] SLLSourceB,
    output reg [2:0] ShiftType
);

    // ESTADOS
    // parameter READAANDB  = 4;
    // parameter SAVELT     = SAVEREGRD; //6
    // parameter SAVEALU    = SAVEREGRD; //10
    // parameter SAVEOR     = SAVEREGRD; //12
    // parameter LOADSHIFT  = 17;
    // parameter SAVESHIFT  = 25;
    parameter RESET      =  0;
    parameter READINST1  =  1;
    parameter READINST2  =  2;
    parameter DECODEINST =  3;
    parameter SLT        =  5;
    parameter SUB        =  7;
    parameter ADD        =  8;
    parameter AND        =  9;
    parameter OR         = 11;
    parameter DIV        = 13;
    parameter MULT       = 14;
    parameter JR         = 15;
    parameter SAVEPC     = 16;
    parameter SLLV       = 21;
    parameter SRAV       = 18;
    parameter SRA        = 19;
    parameter SRL        = 20;
    parameter SLL        = 22;
    parameter MFHI       = 23;
    parameter MFLO       = 24;
    parameter SAVEREGRD  = 26;
    parameter BREAK      = 27;
    parameter RTE        = 28;
    parameter LOADA      = 29;
    parameter LOADB      = 30;
    parameter ATOB       = 31;
    parameter BTOA       = 32;
    parameter ADDI       = 33;
    parameter ADDIU      = 34;
    parameter SLTI       = 35;
    parameter DIVM       = 36;
    parameter LUI        = 37;
    parameter SAVEREGRT  = 53;
    parameter BRNCHCALC  = 38;
    parameter BEQ        = 39;
    parameter BNE        = 40;
    parameter BLE        = 41;
    parameter BGT        = 42;
    parameter CONDSAVEPC = 43;
    parameter SW         = 44;
    parameter READMEM    = 45;
    parameter LW         = 46;
    parameter LH         = 47;
    parameter LB         = 48;
    parameter SH         = 49;
    parameter SB         = 50;
    parameter JUMP       = 51;
    parameter JAL        = 52;
    parameter EXEPTION   = 54;
    parameter INVALIDOP  = 55;
    parameter OVERFLOW   = 56;
    parameter DIVBY0     = 57;



    integer opint;
    integer tempo = 0;
    integer estado = 0;


    // TRANSIÇÃO ENTRE OS ESTADOS
    always @(posedge clk, reset) begin
        if( reset == 1'b1 ) 
        begin
            estado = 0; 
            tempo = 0;
        end 
        else 
        begin
            // TRANSIÇÃO ENTRE OS ESTADOS
            if( estado == RESET )
            begin
                if(tempo == 0) tempo = 2;  //para esperar um ciclo ainda no reset, para gravar na memória
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
            end
            else if(overflowflag)          estado = OVERFLOW;
            else if(estado == READINST1)   estado = READINST2;
            else if(estado == READINST2)   estado = DECODEINST;
            else if(estado == DECODEINST)
            begin
                //INSTRUÇÕES R
                if(opcode == 6'b000000) 
                begin
                         if(funct == 6'b010000) estado = MFHI;  //mfhi  0x10
                    else if(funct == 6'b010010) estado = MFLO;  //mflo  0x12
                    else if(funct == 6'b001101) estado = BREAK; //break 0xd
                    else if(funct == 6'b010011) estado = RTE;   //rte   0x13
                    else if(funct == 6'b000101) estado = LOADA; //xchg  0x5
                    else if(funct == 6'b101010) estado = SLT;   //slt   0x2a
                    else if(funct == 6'b100010) estado = SUB;   //sub   0x22
                    else if(funct == 6'b100000) estado = ADD;   //add   0x20
                    else if(funct == 6'b100100) estado = AND;   //and   0x24
                    else if(funct == 6'b100101) estado = OR;    //or    0x25
                    else if(funct == 6'b011010) estado = DIV;   //div   0x1a
                    else if(funct == 6'b011000) estado = MULT;  //mul   0x18
                    else if(funct == 6'b001000) estado = JR;    //JR    0x8
                    else if(funct == 6'b000100) estado = SLLV;  //SLLV  0x4
                    else if(funct == 6'b000111) estado = SRAV;  //SRAV  0x7
                    else if(funct == 6'b000011) estado = SRA;   //SRA   0x3
                    else if(funct == 6'b000010) estado = SRL;   //SRL   0x2
                    else if(funct == 6'b000000) estado = SLL;   //SLL   0x0
                    else estado = INVALIDOP;
                end
                // INSTRUÇÕES I
                else if(opcode == 6'b001000) estado = ADDI;     //ADDI  0x8
                else if(opcode == 6'b001001) estado = ADDIU;    //ADDIU 0x9
                else if(opcode == 6'b001010) estado = SLTI;     //SLTI  0xa
                else if(opcode == 6'b000001) estado = DIVM;     //DIVM  0x1
                else if(opcode == 6'b001111) estado = LUI;      //LUI   0xf
                else if(opcode == 6'b000100) estado = BRNCHCALC;//BEQ   0x4
                else if(opcode == 6'b000101) estado = BRNCHCALC;//BNE   0x5
                else if(opcode == 6'b000110) estado = BRNCHCALC;//BLE   0x6
                else if(opcode == 6'b000111) estado = BRNCHCALC;//BGT   0x7
                else if(opcode == 6'b101011) estado = SW;       //SW    0x2b
                else if(opcode == 6'b100011) estado = READMEM;  //LW    0x23
                else if(opcode == 6'b100001) estado = READMEM;  //LH    0x21
                else if(opcode == 6'b100000) estado = READMEM;  //LB    0x20
                else if(opcode == 6'b101001) estado = READMEM;  //SH    0x29
                else if(opcode == 6'b101000) estado = READMEM;  //SB    0x28
                // INSTRUÇÕES J
                else if(opcode == 6'b000010) estado = JUMP;     //J     0x2
                else if(opcode == 6'b000011) estado = JAL;      //JAL   0x3
                else estado = INVALIDOP;
            end
            // INSTRUÇÕES R - TRANSIÇÕES
            else if(estado == SLT)     estado = SAVEREGRD;//SAVELT;
            else if(estado == SUB)     estado = SAVEREGRD;//SAVEALU;
            else if(estado == ADD)     estado = SAVEREGRD;//SAVEALU;
            else if(estado == AND)     estado = SAVEREGRD;//SAVEALU;
            else if(estado == OR)      estado = SAVEREGRD;//SAVEOR;
            else if(estado == JR)      estado = SAVEPC;
            else if(estado == SAVEPC)  estado = READINST1;
            else if(estado == SLLV)    estado = SAVEREGRD;
            else if(estado == SRAV)    estado = SAVEREGRD;
            else if(estado == SRA)     estado = SAVEREGRD;
            else if(estado == SRL)     estado = SAVEREGRD;
            else if(estado == SLL)     estado = SAVEREGRD;
            else if(estado == MFHI)    estado = SAVEREGRD;
            else if(estado == MFLO)    estado = SAVEREGRD;
            else if(estado == BREAK)   estado = SAVEPC;
            else if(estado == RTE)     estado = READINST1;
            else if(estado == DIV || estado == MULT)
            begin
                if(tempo == 0) tempo = 32; //espera 32 ciclos para completar a divisão/multiplicação
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
                if(divby0flag) estado = DIVBY0;
            end
            else if(estado == LOADA)   //xchg load a
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = LOADB;
            end
            else if(estado == LOADB)  //xchg load b
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = ATOB;
            end
            else if(estado == ATOB)    estado = BTOA;
            else if(estado == BTOA)    estado = READINST1;
            // INSTRUÇÕES I - TRANSIÇÕES
            else if(estado == ADDI)    estado = SAVEREGRT;
            else if(estado == ADDIU)   estado = SAVEREGRT;
            else if(estado == SLTI)    estado = SAVEREGRT;
            else if(estado == LUI)     estado = SAVEREGRT;
            else if(estado == SAVEREGRT)estado= READINST1;
            else if(estado == DIVM)
            begin 
                if(tempo == 0) tempo = 33;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
                if(divby0flag) estado = DIVBY0;
            end
            else if(estado == BRNCHCALC)
            begin
                     if(opcode == 6'b000100) estado = BEQ;//BEQ   0x4
                else if(opcode == 6'b000101) estado = BNE;//BNE   0x5
                else if(opcode == 6'b000110) estado = BLE;//BLE   0x6
                else if(opcode == 6'b000111) estado = BGT;//BGT   0x7
            end
            else if(estado == BEQ)     estado = CONDSAVEPC;
            else if(estado == BNE)     estado = CONDSAVEPC;
            else if(estado == BLE)     estado = CONDSAVEPC;
            else if(estado == BGT)     estado = CONDSAVEPC;
            else if(estado == CONDSAVEPC) estado = READINST1;
            else if(estado == READMEM) 
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0)
                begin
                         if(opcode == 6'b100011) estado = LW;  //LW    0x23
                    else if(opcode == 6'b100001) estado = LH;  //LH    0x21
                    else if(opcode == 6'b100000) estado = LB;  //LB    0x20
                    else if(opcode == 6'b101001) estado = SH;  //SH    0x29
                    else if(opcode == 6'b101000) estado = SB;  //SB    0x28
                end
            end
            else if(estado == LW) estado = READINST1;
            else if(estado == LH) estado = READINST1;
            else if(estado == LB) estado = READINST1;
            else if(estado == SW) estado = READINST1;
            else if(estado == SH) estado = READINST1;
            else if(estado == LB) estado = READINST1;
            // INSTRUÇÕES J - TRANSIÇÃO
            else if(estado == JUMP) estado = READINST1;
            else if(estado == JAL)  estado = READINST1;
            else ExceptionAdress = -1; /// !!! marcação para debug
        end
    end



    //// SAÍDAS DE ACORDO COM OS ESTADOS

    always @(estado) begin

        // RESETA TUDO POR PADRÃO //
        ALUSrcB = 3'd0;
        ALUSrcA = 1'b0;
        PCWriteCond = 1'b0;
        PCWrite = 1'b0;
        IorD = 1'b0;
        SrcAddr = 2'b00;
        WR= 1'b0;
        ResetTrigger = 1'b0;
        SaveTemp = 1'b0;
        MemToReg = 3'b000;
        SizeHandler 3'b000;
        IRWrite = 1'b0;
        ExceptionAdress = 32'd0;
        DataSource = 1'b0;
        EPCWrite = 1'b0;
        RegDest = 2'b00;
        RegWrite = 1'b0;
        ALUSrcA = 1'b0;
        ALUSrcB = 3'b000;
        AluOutLoad = 1'b0;
        ControlType = 5'b0;
        PCSource = 3'd0;
        SLLSourceA = 2'b00;
        SLLSourceB = 2'b00;
        ShiftType = 3'b000;
        ///////////////////////////

    end


endmodule

/*

        // RESETA TUDO POR PADRÃO //
        ALUSrcB = 3'd0;
        ALUSrcA = 1'b0;
        PCWriteCond = 1'b0;
        PCWrite = 1'b0;
        IorD = 1'b0;
        SrcAddr = 2'b00;
        WR= 1'b0;
        ResetTrigger = 1'b0;
        SaveTemp = 1'b0;
        MemToReg = 3'b000;
        SizeHandler 3'b000;
        IRWrite = 1'b0;
        ExceptionAdress = 32'd0;
        DataSource = 1'b0;
        EPCWrite = 1'b0;
        RegDest = 2'b00;
        RegWrite = 1'b0;
        ALUSrcA = 1'b0;
        ALUSrcB = 3'b000;
        AluOutLoad = 1'b0;
        ControlType = 5'b0;
        PCSource = 3'd0;
        SLLSourceA = 2'b00;
        SLLSourceB = 2'b00;
        ShiftType = 3'b000;
        ///////////////////////////
*/