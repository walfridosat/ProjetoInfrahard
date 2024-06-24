module ALUControl (
    input wire [4:0] controlType,
    input wire [0:0] ALUOutSaveCPU,
    output reg [1:0] condType,
    output reg [0:0] divOp,
    output reg [0:0] multOp,
    output reg [2:0] ALUOp,
    output reg [0:0] orOp,
    output reg [0:0] overflowOp,
    output reg [2:0] SrcOut,
    output reg [1:0] StoreMD,
    output reg [0:0] ALUOutSave
);

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

    initial condType = 2'b00;

    always @(controlType) begin
        // condType = 2'b00; // não deixa mudar enquanto não explicitamente tentar mudar
        divOp = 1'b0;
        multOp = 1'b0;
        ALUOp = 3'b000;
        orOp = 1'b0;
        overflowOp = 1'b0;
        SrcOut = 3'b000;
        StoreMD = 2'b00;
        ALUOutSave = 1'b0;
        
        case (controlType)
            5'b00000:
                begin
                    ALUOp = 3'b000;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00001:
                begin
                    ALUOp = 3'b001;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00010:
                begin
                    ALUOp = 3'b010;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00011:
                begin
                    ALUOp = 3'b011;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00100:
                begin
                    ALUOp = 3'b100;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00101:
                begin
                    ALUOp = 3'b101;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00110:
                begin
                    ALUOp = 3'b110;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b00111:
                begin
                    ALUOp = 3'b111;
                    SrcOut = 3'b010;
                    ALUOutSave = 1'b1;
                end
            5'b01000:
                begin
                    orOp = 1'b1;
                    SrcOut = 3'b100;
                    ALUOutSave = 1'b1;
                end
            5'b01001:
                begin
                    divOp = 1'b1;
                    StoreMD = 2'b01;
                end
            5'b01010:
                begin
                    multOp = 1'b1;
                    StoreMD = 2'b10;
                end
            5'b01011:
                begin
                    ALUOp = 3'b001;
                    SrcOut = 3'b011;
                    ALUOutSave = 1'b1;
                end
            5'b01100:
                begin 
                    SrcOut = 3'b001;
                    ALUOutSave = 1'b1;
                end
            5'b01101:
                begin
                    SrcOut = 3'b000;
                    ALUOutSave = 1'b1;
                end
            5'b01110:
                begin
                    ALUOp = ALUCMP;
                    condType = 2'b00;
                end
            5'b01111:
                begin 
                    ALUOp = ALUCMP;
                    condType = 2'b01;
                end
            5'b10000:
                begin
                    ALUOp = ALUCMP;
                    condType = 2'b10;
                end
            5'b10001:
                begin
                    ALUOp = ALUCMP;
                    condType = 2'b11;
                end
            5'b10010:
                begin
                    SrcOut = 3'b110;
                    ALUOutSave = 1'b1;
                end

        endcase

        ALUOutSave = ALUOutSave & ALUOutSaveCPU; // !!! ALUOutSaveCPU é constante 1 exceto no Branch
    end

endmodule

/*

TODOS OS CASOS DE CONTROLTYPE

* 00000: S = X
* 00001: S = X + Y (com overflow)
* 00010: S = X - Y
* 00011: S = X and Y
* 00100: S = X + 1
* 00101: S = not X
* 00110: S = X xor Y
* 00111: S = X comp Y
* 01000: S = X or Y
* 01001: S = X / Y
* 01010: S = X * Y
* 01011: S = X + Y (sem overflow)
* 01100: S = hi
* 01101: S = lo
* 01110: cond NE 
* 01111: cond EQ
* 10000: cond LE
* 10001: cond GT
* 10010: qualquer caso de shift

*/





