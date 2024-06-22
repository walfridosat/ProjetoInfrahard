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

    integer opint;
    integer i;
    always @(posedge clk, posedge reset) begin

        opint = opcode;

        if(opint == 0) // tipo R
        begin 
            case(funct)
                6'd4: //SLLV
                    begin
                        SLLSourceA = 2'b00;
                        ShiftType = 3'b001;
                        @(posedge clk);
                        SLLSourceB = 2'b00;
                        ShiftType = 3'b010;
                        ControlType = 5'b10010;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd7: //SRAV 
                    begin
                        SLLSourceA = 2'b00;
                        ShiftType = 3'b001;
                        @(posedge clk);
                        SLLSourceB = 2'b00;
                        ShiftType = 3'b100;
                        ControlType = 5'b10010;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd3: //SRA
                    begin
                        SLLSourceA = 2'b10;
                        ShiftType = 3'b001;
                        @(posedge clk);
                        SLLSourceB = 2'b10;
                        ShiftType = 3'b100;
                        ControlType = 5'b10010;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd2: //SRL
                    begin
                        SLLSourceA = 2'b10;
                        ShiftType = 3'b001;
                        @(posedge clk);
                        SLLSourceB = 2'b10;
                        ShiftType = 3'b011;
                        ControlType = 5'b10010;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd0: //SLL
                    begin
                        SLLSourceA = 2'b10;
                        ShiftType = 3'b001;
                        @(posedge clk);
                        SLLSourceB = 2'b10;
                        ShiftType = 3'b010;
                        ControlType = 5'b10010;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                
                6'd19:  // rte
                    begin 

                        PCSource = 3'd4;
                        PCWrite = 1'd1; 

                    end

                6'd13:  //break

                    begin

                        ALUSrcA = 1'd0;
                        ALUSrcB = 3'd1;
                        ControlType = 5'd2;
                        @(posedge clk);
                        PCSource = 3'd1;
                        PCWrite = 1'd1;
                    
                    end

                // ALUSrcA = 1 & ALUSrcB = 000
                
                6'd42:  //slt
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'b00111;
                        @(posedge clk);
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd34:  //sub
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd2;
                        @(posedge clk);
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd32:  //add
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd1;
                        @(posedge clk);
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd36:  //and
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd3;
                        @(posedge clk);
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end
                
                6'd37:  //or
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd2;
                        @(posedge clk);
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd26:  //mult
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'b01010;

                        for (i = 31; i >= 0; i = i - 1) begin
                           @(posedge clk);
                        end 

                    end

                6'd24:  //div
                    begin 
                    
                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'b01001;
                        for (i = 31; i >= 0; i = i - 1) begin
                            @(posedge clk);
                        end

                    end

                6'd24:  //jr
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd0;
                        @(posedge clk);
                        PCSource = 3'd1;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1;
                        PCWriteCond = 1'd0;
                    
                    end
                
                6'd16: //mfhi
                    begin
                        ControlType = 5'b01100;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd18: //mflo
                    begin
                        ControlType = 5'b01101;
                        @(posedge clk);
                        MemToReg = 3'b000;
                        RegDest = 2'b01;
                        RegWrite = 1'b1;
                    end
                6'd5: //xchg
                    begin
                        SrcAddr = 4'b0100;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b000;
                        SaveTemp = 1'b1;
                        SrcAddr = 4'b0101;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        DataSource = 1'b0;
                        SrcAddr = 4'b0101;
                        WR = 1'b1;
                        @(posedge clk);
                        WR = 1'b0;
                        DataSource = 1'b1;
                        SrcAddr = 4'b0100;
                        WR = 1'b1;
                        SaveTemp = 1'b0;
                    end

            endcase

        end
        
        else if (opint == 2 | opint == 3) //tipo j

        begin

            case(opcode)

                6'd2: //j
                    begin

                        PCSource = 3'd0;
                        PCWrite = 1'd1;

                    end

                6'd3: //jal
                    begin

                        PCSource = 2'd0;
                        PCWrite = 1'd1;
                        RegDest = 3'd2;
                        MemToReg = 3'd4;
                        WR = 1'd1;

                    end

            endcase

        end

        else //tipo i

        begin

            case(opcode)

                6'd1: //divm
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd9;
                        for (i = 31; i >= 0; i = i - 1) begin
                            @(posedge clk);
                        end

                    end
                6'd8: //addi
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd1;
                        @(posedge clk);
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd9: //addiu
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd1;
                        @(posedge clk);
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd9: // slti
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd7;
                        @(posedge clk);
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd15: //lui
                    begin

                        SLLSourceA = 2'd1;
                        ShiftType = 3'd1;
                        @(posedge clk);
                        SLLSourceB = 2'd1;
                        ShiftType = 3'd2;
                        @(posedge clk);
                        ControlType = 5'b10010;
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd4: //beq
                    begin

                        ALUSrcA = 0;
                        ALUSrcB = 3'd3;
                        ControlType = 5'd1;
                        @(posedge clk);
                        ALUSrcA = 1'd1;
                        ALUSrcB = 0;
                        ControlType = 5'b01111;
                        PCSource = 3'b010;
                        PCWriteCond = 1'b1;
                        
                    end
                6'd5: //bne
                    begin

                        ALUSrcA = 0;
                        ALUSrcB = 3'd3;
                        ControlType = 5'd1;
                        @(posedge clk);
                        ALUSrcA = 1'd1;
                        ALUSrcB = 0;
                        ControlType = 5'b01110;
                        PCSource = 3'b010;
                        PCWriteCond = 1'b1;

                    end
                6'd6: //ble
                    begin

                        ALUSrcA = 0;
                        ALUSrcB = 3'd3;
                        ControlType = 5'd1;
                        @(posedge clk);
                        ALUSrcA = 1'd1;
                        ALUSrcB = 0;
                        ControlType = 5'b10000;
                        PCSource = 3'b010;
                        PCWriteCond = 1'b1;

                    end
                6'd7: //bgt
                    begin

                        ALUSrcA = 0;
                        ALUSrcB = 3'd3;
                        ControlType = 5'd1;
                        @(posedge clk);
                        ALUSrcA = 1'd1;
                        ALUSrcB = 0;
                        ControlType = 5'b10001;
                        PCSource = 3'b010;
                        PCWriteCond = 1'b1;

                    end
                6'd34: //sw
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        SizeHandler = 3'b000;
                        DataSource = 1'b1;
                        WR = 1'b1;

                    end
                6'd41: //sh
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b011;
                        DataSource = 1'b1;
                        WR = 1'b1;

                    end
                6'd40: //sb
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b101;
                        DataSource = 1'b1;
                        WR = 1'b1;

                    end
                6'd35: //lw
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b000;
                        MemToReg = 3'b001;
                        RegDest = 1'b0;
                        RegWrite = 1'b1;

                    end
                6'd33: //lh
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b001;
                        MemToReg = 3'b001;
                        RegDest = 1'b0;
                        RegWrite = 1'b1;

                    end
                6'd32: //lb
                    begin

                        ALUSrcA = 1'b1;
                        ALUSrcB = 3'b010;
                        ControlType = 5'b00001;
                        @(posedge clk);
                        IorD = 1'b1;
                        SrcAddr = 3'b000;
                        WR = 1'b0;
                        @(posedge clk);
                        @(posedge clk);
                        SizeHandler = 3'b010;
                        MemToReg = 3'b001;
                        RegDest = 1'b0;
                        RegWrite = 1'b1;

                    end

            endcase

        end

    end
endmodule