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
    output reg [0:0] ALUOutSaveCPU,  // !!! para auxiliar no branch // 
    output reg [2:0] PCSource,
    output reg [1:0] SLLSourceA,
    output reg [1:0] SLLSourceB,
    output reg [2:0] ShiftType
);

    // ESTADOS
    // parameter SAVELT     = SAVEREGRD; //6
    // parameter SAVEALU    = SAVEREGRD; //10
    // parameter SAVEOR     = SAVEREGRD; //12
    // parameter SAVESHIFT  = ;
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
    parameter LOADSHFT   = 25;
    parameter LOADSHFTV  = 17;
    parameter SLLV       = 21;
    parameter SRAV       = 18;
    parameter SRA        = 19;
    parameter SRL        = 20;
    parameter SLL        = 22;
    parameter MFHI       = 23;
    parameter MFLO       = 24;
    parameter SAVEREGRD  = 26;
    parameter BREAK      = 27;
    parameter SAVEPCBK   = 06;
    parameter RTE        = 28;
    parameter LOADA      = 29;
    parameter LOADB      = 30;
    parameter ATOB       = 31;
    parameter BTOA       = 32;
    parameter ADDI       = 33;
    parameter ADDIU      = 34;
    parameter SLTI       = 35;
    parameter DIVM       = 36;
    parameter LOADSLUI   = 12; 
    parameter LUI        = 37;
    parameter SAVEREGRT  = 53;
    parameter BRNCHCALC  = 38;
    parameter BEQ        = 39;
    parameter BNE        = 40;
    parameter BLE        = 41;
    parameter BGT        = 42;
    parameter CONDSAVEPC = 43;
    parameter MEMOCALC   = 04;
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
            else if(estado == READINST1) //estado = READINST2;
            begin 
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0)  estado = READINST2;
            end
            else if(estado == READINST2)   estado = DECODEINST;
            else if(estado == DECODEINST)
            begin
                //INSTRUÇÕES R
                if(opcode == 6'b000000) 
                begin
                         if(funct == 6'b010000) estado = MFHI;    //mfhi  0x10
                    else if(funct == 6'b010010) estado = MFLO;    //mflo  0x12
                    else if(funct == 6'b001101) estado = BREAK;   //break 0xd
                    else if(funct == 6'b010011) estado = RTE;     //rte   0x13
                    else if(funct == 6'b000101) estado = LOADA;   //xchg  0x5
                    else if(funct == 6'b101010) estado = SLT;     //slt   0x2a
                    else if(funct == 6'b100010) estado = SUB;     //sub   0x22
                    else if(funct == 6'b100000) estado = ADD;     //add   0x20
                    else if(funct == 6'b100100) estado = AND;     //and   0x24
                    else if(funct == 6'b100101) estado = OR;      //or    0x25
                    else if(funct == 6'b011010) estado = DIV;     //div   0x1a
                    else if(funct == 6'b011000) estado = MULT;    //mul   0x18
                    else if(funct == 6'b001000) estado = JR;      //JR    0x8
                    else if(funct == 6'b000100) estado = LOADSHFTV;//SLLV  0x4
                    else if(funct == 6'b000111) estado = LOADSHFTV;//SRAV  0x7
                    else if(funct == 6'b000011) estado = LOADSHFT;//SRA   0x3
                    else if(funct == 6'b000010) estado = LOADSHFT;//SRL   0x2
                    else if(funct == 6'b000000) estado = LOADSHFT;//SLL   0x0
                    else estado = INVALIDOP;
                end
                // INSTRUÇÕES I
                else if(opcode == 6'b001000) estado = ADDI;     //ADDI  0x8
                else if(opcode == 6'b001001) estado = ADDIU;    //ADDIU 0x9
                else if(opcode == 6'b001010) estado = SLTI;     //SLTI  0xa
                else if(opcode == 6'b000001) estado = DIVM;     //DIVM  0x1
                else if(opcode == 6'b001111) estado = LOADSLUI; //LUI   0xf
                else if(opcode == 6'b000100) estado = BRNCHCALC;//BEQ   0x4
                else if(opcode == 6'b000101) estado = BRNCHCALC;//BNE   0x5
                else if(opcode == 6'b000110) estado = BRNCHCALC;//BLE   0x6
                else if(opcode == 6'b000111) estado = BRNCHCALC;//BGT   0x7
                else if(opcode == 6'b100011) estado = MEMOCALC; //LW    0x23
                else if(opcode == 6'b100001) estado = MEMOCALC; //LH    0x21
                else if(opcode == 6'b100000) estado = MEMOCALC; //LB    0x20
                else if(opcode == 6'b101011) estado = MEMOCALC; //SW    0x2b
                else if(opcode == 6'b101001) estado = MEMOCALC; //SH    0x29
                else if(opcode == 6'b101000) estado = MEMOCALC; //SB    0x28
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
            else if(estado == SAVEPCBK)estado = READINST1;
            else if(estado == LOADSHFT)
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0)
                begin
                         if(funct == 6'b000011) estado = SRA;   //SRA   0x3
                    else if(funct == 6'b000010) estado = SRL;   //SRL   0x2
                    else if(funct == 6'b000000) estado = SLL;   //SLL   0x0
                    else estado = INVALIDOP;
                end
            end
            else if(estado == LOADSHFTV)
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0)
                begin
                         if(funct == 6'b000100) estado = SLLV;  //SLLV  0x4
                    else if(funct == 6'b000111) estado = SRAV;  //SRAV  0x7
                    else estado = INVALIDOP;
                end
            end
            else if(estado == SLLV || estado == SRAV || estado == SRA || estado == SRL || estado == SLL) //todos os shift tipo R
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = SAVEREGRD;
            end
            else if(estado == MFHI)    estado = SAVEREGRD;
            else if(estado == MFLO)    estado = SAVEREGRD;
            else if(estado == SAVEREGRD)estado= READINST1;
            else if(estado == BREAK)   estado = SAVEPCBK;
            else if(estado == RTE)     estado = READINST1;
            else if(estado == DIV || estado == MULT)
            begin
                if(tempo == 0) tempo = 34; //espera 32 ciclos para completar a divisão/multiplicação
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
                if(divby0flag)begin tempo = 0; estado = DIVBY0; end
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
            else if(estado == LOADSLUI)
            begin
                 if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = LUI;
            end
            else if(estado == LUI)     //estado = SAVEREGRT;
            begin
                 if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = SAVEREGRT;
            end
            else if(estado == SAVEREGRT)estado= READINST1;
            else if(estado == DIVM)
            begin 
                if(tempo == 0) tempo = 34;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
                if(divby0flag)begin tempo = 0; estado = DIVBY0; end
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
            else if(estado == MEMOCALC)
            begin
                if(opcode ==  6'b101011) estado = SW;  // SW 0x2b
                else estado = READMEM;  // SH/SB/LW/LH/LB
            end
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
            else if(estado == LW)
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
            end
            else if(estado == LH)// estado = READINST1;
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
            end
            else if(estado == LB)// estado = READINST1;
            begin
                if(tempo == 0) tempo = 2;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
            end
            else if(estado == SW) estado = READINST1;
            else if(estado == SH) estado = READINST1;
            else if(estado == SB) estado = READINST1;
            else if(estado == LB) estado = READINST1;
            // INSTRUÇÕES J - TRANSIÇÃO
            else if(estado == JUMP) estado = READINST1;
            else if(estado == JAL)  //estado = READINST1;
            begin
                if(tempo == 0) tempo = 1;
                tempo = tempo - 1;
                if(tempo == 0) estado = READINST1;
            end
            // TRATAMENTOS DE ERROS
            else if(estado == EXEPTION)  estado = READINST1;
            else if(estado == INVALIDOP) // estado = EXEPTION;
            begin
                if(tempo == 0) tempo = 1;
                tempo = tempo - 1;
                if(tempo == 0) estado = EXEPTION;
            end
            else if(estado == DIVBY0)   // estado = EXEPTION;
            begin
                if(tempo == 0) tempo = 1;
                tempo = tempo - 1;
                if(tempo == 0) estado = EXEPTION;
            end
            else if(estado == OVERFLOW)
            begin
                if(tempo == 0) tempo = 1;
                tempo = tempo - 1;
                if(tempo == 0) estado = EXEPTION;
            end
        end
    end


    parameter ALULOAD = 5'b00000; 
    parameter ALUOADD = 5'b00001;
    parameter ALUSUB  = 5'b00010;
    parameter ALUAND  = 5'b00011;
    parameter ALUADD1 = 5'b00100;
    parameter ALUNOT  = 5'b00101;
    parameter ALUXOR  = 5'b00110;
    parameter ALUCMP  = 5'b00111;
    parameter ALUOR   = 5'b01000;
    parameter ALUDIV  = 5'b01001;
    parameter ALUMUL  = 5'b01010;
    parameter ALUSADD = 5'b01011;
    parameter ALUMFHI = 5'b01100;
    parameter ALUMFLO = 5'b01101;
    parameter ALUNE   = 5'b01110;
    parameter ALUEQ   = 5'b01111;
    parameter ALULE   = 5'b10000;
    parameter ALUGT   = 5'b10001;
    parameter ALUSFT  = 5'b10010;





    //// SAÍDAS DE ACORDO COM OS ESTADOS

    always @(estado) begin

        // RESETA TUDO POR PADRÃO //
        ALUSrcB = 3'd0;
        ALUSrcA = 1'b0;
        PCWriteCond = 1'b0;
        PCWrite = 1'b0;
        IorD = 1'b0;
        SrcAddr = 3'b000;
        WR= 1'b0;
        ResetTrigger = 1'b0;
        SaveTemp = 1'b0;
        MemToReg = 3'b000;
        SizeHandler = 3'b000;
        IRWrite = 1'b0;
        ExceptionAdress = 32'd0;
        DataSource = 1'b0;
        EPCWrite = 1'b0;
        RegDest = 2'b00;
        RegWrite = 1'b0;
        ALUSrcA = 1'b0;
        ALUSrcB = 3'b000;
        AluOutLoad = 1'b0;
        if(tempo != 1) ControlType = 5'b00000;
        ALUOutSaveCPU = 1'b1;   // !!! Padrão 1 !!!
        PCSource = 3'd2;
        SLLSourceA = 2'b00;
        SLLSourceB = 2'b00;
        ShiftType = 3'b000;
        ///////////////////////////


        if(estado == RESET)
        begin
            RegDest  = 3'b011; // seleciona o $29
            MemToReg = 3'b010; // seta o $29 como 227
            RegWrite = 1'b1;   // escreve no banco
        end
        else if(estado == READINST1)
        begin
            
            IorD    = 1'b0;    // seleciona o endereço do pc p/ o mux
            SrcAddr = 3'b000;  // seleciona o endereço do pc p/ a memo
            // MemRead = 1'b1; // memória lê automaticamente
        end
        else if(estado == READINST2)
        begin
            ALUSrcA = 1'b0;   // seleciona o PC para operação na ULA como A
            ALUSrcB = 3'b001; // seleciona o 4  para operação na ULA como B
            ControlType = ALUOADD; // soma com overflow
            IRWrite = 1'b1; // carrega a instrução !!! cuidado !!!
        end
        else if(estado == DECODEINST)
        begin
            PCWrite = 1'b1; // !!! Adicionado !!!
            // IRWrite = 1'b1; // !!! cuidado !!!
        end
        // INSTRUÇÕES R
        else if(estado == SLT)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALUCMP;  // S = X comp Y
        end
        else if(estado == SUB)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALUSUB; // S = X - Y
        end
        else if(estado == ADD)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALUOADD; // soma COM OVERFLOW
        end
        else if(estado == AND)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALUAND;
        end
        else if(estado == OR)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALUOR;
        end
        else if(estado == DIV)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALUDIV;
        end
        else if(estado == MULT)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALUMUL;
        end
        else if(estado == JR)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            ControlType = ALULOAD;
            PCSource = 3'b001;
            PCWrite = 1'b1;
        end
        else if(estado == SAVEPC)
        begin
            PCSource = 3'b001;
            PCWrite  = 1'b1;
        end
        else if(estado == SAVEPCBK)
        begin
            PCSource = 3'b010;
            PCWrite  = 1'b1;
        end
        else if(estado == LOADSHFT)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b10; //Entrada A é o B !!!
            SLLSourceB = 2'b10; //Entrada B é o SHAMT !!!
            ShiftType = 3'b001;
            ControlType = ALUSFT;
        end
        else if(estado == LOADSHFTV)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b00; //Entrada A é o A !!!
            SLLSourceB = 2'b00; //Entrada B é o B !!!
            ShiftType = 3'b001;
            ControlType = ALUSFT;
        end
        else if(estado == SLLV)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b00;
            SLLSourceB = 2'b00; //
            ShiftType = 3'b010;
            ControlType = ALUSFT;
        end
        else if(estado == SRAV)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b00;
            SLLSourceB = 2'b00;
            ShiftType = 3'b100;
            ControlType = ALUSFT;
        end
        else if(estado == SRA)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b10;
            SLLSourceB = 2'b10;
            ShiftType = 3'b100;
            ControlType = ALUSFT;
        end
        else if(estado == SRL)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b10;
            SLLSourceB = 2'b10;
            ShiftType = 3'b011;
            ControlType = ALUSFT;
        end
        else if(estado == SLL)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b10; //!!! Entrada é o B
            SLLSourceB = 2'b10;
            ShiftType = 3'b010;
            ControlType = ALUSFT;
        end
        else if(estado == MFHI)
        begin
            ControlType = ALUMFHI;
        end
        else if(estado == MFLO)
        begin
            ControlType = ALUMFLO;
        end
        else if(estado == SAVEREGRD)
        begin
            MemToReg = 3'b000;
            RegDest = 2'b01;
            RegWrite = 1'b1;
        end
        else if(estado == BREAK)
        begin
            ALUSrcA = 1'b0;
            ALUSrcB = 3'b001;
            ControlType = ALUSUB;
        end
        else if(estado == RTE)
        begin
            PCSource = 3'b100;
            PCWrite = 1'b1;
        end
        else if(estado == LOADA)
        begin
            SrcAddr = 3'b100; // Lê da memória na posição de A
            SizeHandler = 3'b100;
        end
        else if(estado == LOADB)
        begin
            SizeHandler = 3'b111;
            SaveTemp = 1'b1;
            SrcAddr = 3'b101;
            // Lê a memória no posição B e salva o A em Temp
        end
        else if(estado == ATOB)
        begin
            SizeHandler = 3'b111;
            DataSource = 1'b0;
            SrcAddr = 3'b101;   // Salva A na pos de B
            WR = 1'b1;
        end
        else if(estado == BTOA)
        begin
            SizeHandler = 3'b111;
            DataSource = 1'b1;
            SrcAddr = 3'b100;   // Salva B na pos de A
            WR = 1'b1;
        end
        // INSTRUIÇÕES I
        else if(estado == ADDI)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUOADD; //soma com overflow
        end
        else if(estado == ADDIU)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUSADD;  // soma sem overflow
        end
        else if(estado == SLTI)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUCMP;
        end
        else if(estado == DIVM)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUDIV;
        end
        else  if(estado == LOADSLUI)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB  = 3'b000;
            SLLSourceA = 2'b01; //!!! Entrada é o imediato
            SLLSourceB = 2'b01;
            ShiftType = 3'b001;
            ControlType = ALUSFT;
        end
        else if(estado == LUI)
        begin
            SLLSourceA = 2'b01; //!!! Entrada é o imediato
            SLLSourceB = 2'b01;
            ShiftType = 3'b010;
            ControlType = ALUSFT; //shift
        end
        else if(estado == SAVEREGRT)
        begin
            MemToReg = 2'b00;
            RegWrite = 1'b1;
            RegDest = 3'b000;
        end
        else if(estado == BRNCHCALC)
        begin
            ALUSrcA = 1'b0;   //seleciona o PC
            ALUSrcB = 3'b011; //+4  // calcula o novo PC após o branch
            ControlType = ALUOADD; // soma com overflow
        end
        else if(estado == BEQ)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALUEQ;
            PCWriteCond = 1'b1;
            tempo = 1;
        end
        else if(estado == BNE)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALUNE;   
            PCWriteCond = 1'b1;
            tempo = 1;
        end
        else if(estado == BLE)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALULE;
            PCWriteCond = 1'b1;
            tempo = 1;
        end
        else if(estado == BGT)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;
            ControlType = ALUGT;
            PCWriteCond = 1'b1;
            tempo = 1;
        end
        else if(estado == CONDSAVEPC)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b000;   //mantem a entrada por segurança
            PCSource = 3'b010;
            // PCWriteCond = 1'b1;
            tempo = 0;
        end
        else if(estado == MEMOCALC)
        begin
            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUOADD; // soma com overflow p/ saber pos da memória
        end
        else if(estado == SW)
        begin
            IorD = 1'b1;
            SrcAddr = 3'b000;
            SizeHandler =3'b001;
            DataSource = 1'b1;
            WR = 1'b1;

            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUOADD;
        end
        else if(estado == READMEM)
        begin
            IorD = 1'b1;
            SrcAddr = 3'b000; //Lê da memória na pos calculada em MEMOCALC

            ALUSrcA = 1'b1;
            ALUSrcB = 3'b010;
            ControlType = ALUOADD;
        end
        else if(estado == LW)
        begin
            SizeHandler = 3'b100;
            MemToReg = 3'b001;
            RegDest = 1'b0;
            RegWrite = 1'b1;

            IorD = 1'b1;
            SrcAddr = 3'b000;
        end
        else if(estado == LH)
        begin
            SizeHandler = 3'b101;
            MemToReg = 3'b001;
            RegDest = 1'b0;
            RegWrite = 1'b1;

            IorD = 1'b1;
            SrcAddr = 3'b000;
        end
        else if(estado == LB)
        begin
            SizeHandler = 3'b011;
            MemToReg = 3'b001;
            RegDest = 1'b0;
            RegWrite = 1'b1;

            IorD = 1'b1;
            SrcAddr = 3'b000;
        end
        else if(estado == SH)
        begin
            SizeHandler = 3'b010;
            DataSource = 1'b1;
            WR = 1'b1;

            IorD = 1'b1;
            SrcAddr = 3'b000;
        end
        else if(estado == SB)
        begin
            SizeHandler = 3'b000;
            DataSource = 1'b1;
            WR = 1'b1;

            IorD = 1'b1;
            SrcAddr = 3'b000;
        end
        // INSTRUÇÕES J
        else if(estado == JUMP)
        begin
            PCSource = 2'b00;
            PCWrite = 1'b1;
        end
        else if(estado == JAL)
        begin
            PCSource = 2'b00;
            PCWrite = 1'b1;
            RegDest = 3'b010;
            MemToReg = 3'b100;
            // WR = 1'b1;
            RegWrite = 1'b1;
        end
        // TRATAMENTO DE ERROS
        else if(estado == EXEPTION)
        begin
            MemToReg = 2'b11;
            RegDest = 3'b011;
            SizeHandler = 3'b011; //LB !!!
            PCSource = 3'b011;
        end
        else if(estado == INVALIDOP)
        begin
            SrcAddr = 3'b011;
            // !!!
            MemToReg = 2'b01;
            RegDest = 3'b011;
            SizeHandler = 3'b011; //LB !!!
            PCSource = 3'b011;
            PCWrite = 1'b1;
            EPCWrite = 1'b1;
        end
        else if(estado == OVERFLOW)
        begin
            SrcAddr = 3'b001;
            // !!!
            MemToReg = 2'b01;
            RegDest = 3'b011;
            SizeHandler = 3'b011; //LB !!!
            PCSource = 3'b011;
            PCWrite = 1'b1;
            EPCWrite = 1'b1;
        end
        else if(estado == DIVBY0)
        begin
            SrcAddr = 3'b010;
            // !!!
            MemToReg = 2'b01;
            RegDest = 3'b011;
            SizeHandler = 3'b011; //LB !!!
            PCSource = 3'b011;
            PCWrite = 1'b1;
            EPCWrite = 1'b1;
        end

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