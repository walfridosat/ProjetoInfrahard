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
    output reg [2:0]    ,
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
    integer i = 32'd0;

    initial 
    begin
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
    end

    always @(posedge clk) begin

        if(reset == 1'b1) begin
            i = 0;
        end  else  begin
            i = i + 1;
        end

        ALUSrcB = 3'b000;
        ALUSrcA = 1'b0;

        if(i == 0) begin
            
        end

        if (i == 1)
            begin
                IorD = 1'b1;
                SrcAddr = 3'b000;
                WR = 1'b0;
                ALUSrcA = 1'b0;
            end
        else if (i == 2)
            begin
                ALUSrcA = 1'b0;
                ALUSrcB = 3'b001;
                ControlType = 5'b00001;
            end
        else
            begin

                if(i == 3) begin 
                    PCSource = 3'd2;
                    PCWrite = 1'b1;
                end
                
                
                opint = opcode;
                
                if(opint == 0) // tipo R
                begin 
                    case(funct)
                        6'd4: //SLLV
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'b00;
                                        ShiftType = 3'b001;
                                    end
                                    32'd4: begin
                                @(posedge clk);
                                        SLLSourceB = 2'b00;
                                        ShiftType = 3'b010;
                                        ControlType = 5'b10010;
                                    end
                                    32'd5: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd7: //SRAV 
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'b00;
                                        ShiftType = 3'b001;
                                    end
                                    32'd4: begin
                                        SLLSourceB = 2'b00;
                                        ShiftType = 3'b100;
                                        ControlType = 5'b10010;
                                    end
                                    32'd5: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd3: //SRA
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'b10;
                                        ShiftType = 3'b001;
                                    end
                                    32'd4: begin
                                        SLLSourceB = 2'b10;
                                        ShiftType = 3'b100;
                                        ControlType = 5'b10010;
                                    end
                                    32'd5: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd2: //SRL
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'b10;
                                        ShiftType = 3'b001;
                                    end
                                    32'd4: begin
                                        SLLSourceB = 2'b10;
                                        ShiftType = 3'b011;
                                        ControlType = 5'b10010;
                                    end
                                    32'd5: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd0: //SLL
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'b10;
                                        ShiftType = 3'b001;
                                    end
                                    32'd4: begin
                                        SLLSourceB = 2'b10;
                                        ShiftType = 3'b010;
                                        ControlType = 5'b10010;
                                    end
                                    32'd5: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        
                        6'd19:  // rte
                            begin 
                                case(i)
                                    32'd3: begin
                                        PCSource = 3'd4;
                                        PCWrite = 1'd1; 
                                        i = 0;
                                    end
                                endcase

                            end

                        6'd13:  //break
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd0;
                                        ALUSrcB = 3'd1;
                                        ControlType = 5'd2;
                                    end
                                    32'd4: begin
                                        PCSource = 3'd1;
                                        PCWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase
                            end

                        // ALUSrcA = 1 & ALUSrcB = 000
                        
                        6'd42:  //slt
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'b00111;
                                    end
                                    32'd4: begin
                                        MemToReg = 2'd0;
                                        RegDest = 3'd1;
                                        RegWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase

                            end

                        6'd34:  //sub
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'd2;
                                    end
                                    32'd4: begin
                                        MemToReg = 2'd0;
                                        RegDest = 3'd1;
                                        RegWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase

                            end

                        6'd32:  //add
                            begin 
                                case (i) 
                                    32'd3:
                                        begin
                                            ALUSrcA = 1'd1;
                                            ALUSrcB = 3'd0;
                                            ControlType = 5'd1;
                                        end
                                    32'd4:
                                        begin
                                            MemToReg = 2'd0;
                                            RegDest = 3'd1;
                                            RegWrite = 1'd1;
                                            i = 0;
                                        end
                                endcase
                            end

                        6'd36:  //and
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'd3;
                                    end
                                    32'd5: begin
                                        MemToReg = 2'd0;
                                        RegDest = 3'd1;
                                        RegWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase
                            end
                        
                        6'd37:  //or
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'd2;
                                    end
                                    32'd4: begin
                                        MemToReg = 2'd0;
                                        RegDest = 3'd1;
                                        RegWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase

                            end

                        6'd26:  //mult
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'b01010;
                                    end
                                    32'd35: begin
                                        i = 0;
                                    end
                                endcase

                            end

                        6'd24:  //div
                            begin 
                                case(i)
                                    32'd3: begin
                            
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'b01001;
                                    end
                                    32'd35: begin
                                        i = 0;
                                    end
                                endcase
                            end

                        6'd24:  //jr
                            begin 
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'd0;
                                    end
                                    32'd4: begin
                                        PCSource = 3'd1;
                                        PCWriteCond = 1'd1;
                                        PCWrite = 1'd1;
                                        PCWriteCond = 1'd0;
                                        i = 0;
                                    end
                                endcase
                            
                            end
                        
                        6'd16: //mfhi
                            begin
                                case(i)
                                    32'd3: begin
                                        ControlType = 5'b01100;
                                    end
                                    32'd4: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd18: //mflo
                            begin
                                case(i)
                                    32'd3: begin
                                        ControlType = 5'b01101; 
                                    end
                                    32'd4: begin
                                        MemToReg = 3'b000;
                                        RegDest = 2'b01;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd5: //xchg
                            begin
                                case(i)
                                    32'd3: begin
                                        SrcAddr = 4'b0100;
                                        WR = 1'b0;
                                    end
                                    32'd5: begin
                                        SizeHandler = 3'b000;
                                        SaveTemp = 1'b1;
                                        SrcAddr = 4'b0101;
                                        WR = 1'b0;
                                    end
                                    32'd7: begin
                                        DataSource = 1'b0;
                                        SrcAddr = 4'b0101;
                                        WR = 1'b1;
                                    end
                                    32'd8: begin
                                        WR = 1'b0;
                                        DataSource = 1'b1;
                                        SrcAddr = 4'b0100;
                                        WR = 1'b1;
                                        SaveTemp = 1'b0;
                                        i = 0;
                                    end
                                endcase
                            end

                    endcase

                end
                
                else if (opint == 2 | opint == 3) //tipo j

                begin

                    case(opint)

                        6'd2: //j
                            begin
                                case(i)
                                    32'd3: begin
                                        PCSource = 3'd0;
                                        PCWrite = 1'd1;
                                        i = 0;
                                    end
                                endcase
                            end

                        6'd3: //jal
                            begin
                                case(i)
                                    32'd3: begin
                                        PCSource = 2'd0;
                                        PCWrite = 1'd1;
                                        RegDest = 3'd2;
                                        MemToReg = 3'd4;
                                        WR = 1'd1;
                                        i = 0;
                                    end
                                endcase
                            end

                    endcase

                end

                else //tipo i

                begin

                    case(opint)

                        6'd1: //divm
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd2;
                                        ControlType = 5'd9;
                                    end
                                    32'd35: begin
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd8: //addi
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd2;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        MemToReg = 3'd0;
                                        RegDest = 3'd0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase                

                            end
                        6'd9: //addiu
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd2;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        MemToReg = 3'd0;
                                        RegDest = 3'd0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase                                

                            end
                        6'd9: // slti
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd2;
                                        ControlType = 5'd7;
                                    end
                                    32'd4: begin
                                        MemToReg = 3'd0;
                                        RegDest = 3'd0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase

                            end
                        6'd15: //lui
                            begin
                                case(i)
                                    32'd3: begin
                                        SLLSourceA = 2'd1;
                                        ShiftType = 3'd1;
                                    end
                                    32'd4: begin
                                        SLLSourceB = 2'd1;
                                        ShiftType = 3'd2;
                                    end
                                    32'd5: begin
                                        ControlType = 5'b10010;
                                        MemToReg = 3'd0;
                                        RegDest = 3'd0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase

                            end
                        6'd4: //beq
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 0;
                                        ALUSrcB = 3'd3;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'b01111;
                                        PCSource = 3'b010;
                                        PCWriteCond = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd5: //bne
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 0;
                                        ALUSrcB = 3'd3;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 3'd0;
                                        ControlType = 5'b01110;
                                        PCSource = 3'b010;
                                        PCWriteCond = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd6: //ble
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 0;
                                        ALUSrcB = 3'd3;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 0;
                                        ControlType = 5'b10000;
                                        PCSource = 3'b010;
                                        PCWriteCond = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd7: //bgt
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 0;
                                        ALUSrcB = 3'd3;
                                        ControlType = 5'd1;
                                    end
                                    32'd4: begin
                                        ALUSrcA = 1'd1;
                                        ALUSrcB = 0;
                                        ControlType = 5'b10001;
                                        PCSource = 3'b010;
                                        PCWriteCond = 1'b1;
                                        i = 0;
                                    end
                                endcase

                            end
                        6'd34: //sw
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        SizeHandler = 3'b000;
                                        DataSource = 1'b1;
                                        WR = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd41: //sh
                            begin
                                case(i)
                                    32'd3: begin
                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        WR = 1'b0;
                                    end
                                    32'd6: begin
                                        SizeHandler = 3'b011;
                                        DataSource = 1'b1;
                                        WR = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd40: //sb
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        WR = 1'b0;
                                    end
                                    32'd6: begin
                                        SizeHandler = 3'b101;
                                        DataSource = 1'b1;
                                        WR = 1'b1;
                                        i = 0;
                                    end
                                endcase

                            end
                        6'd35: //lw
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        WR = 1'b0;
                                    end
                                    32'd6: begin
                                        SizeHandler = 3'b000;
                                        MemToReg = 3'b001;
                                        RegDest = 1'b0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase

                            end
                        6'd33: //lh
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        WR = 1'b0;
                                    end
                                    32'd6: begin
                                        SizeHandler = 3'b001;
                                        MemToReg = 3'b001;
                                        RegDest = 1'b0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end
                        6'd32: //lb
                            begin
                                case(i)
                                    32'd3: begin

                                        ALUSrcA = 1'b1;
                                        ALUSrcB = 3'b010;
                                        ControlType = 5'b00001;
                                    end
                                    32'd4: begin
                                        IorD = 1'b1;
                                        SrcAddr = 3'b000;
                                        WR = 1'b0;
                                    end
                                    32'd6: begin
                                        SizeHandler = 3'b010;
                                        MemToReg = 3'b001;
                                        RegDest = 1'b0;
                                        RegWrite = 1'b1;
                                        i = 0;
                                    end
                                endcase
                            end

                    endcase

                end
            end

    end
endmodule