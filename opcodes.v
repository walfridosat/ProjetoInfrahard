module opcodelogic (
    input wire [5:0] opcode,
    input wire [5:0] funct,
    input wire overflowflag,
    input wire divby0flag,

    output reg [0:0] PCWriteCond,
    output reg [0:0] PCWrite,
    output reg [0:0] IorD,
    output reg [2:0] SrcAddr,
    output reg [2:0] SrcOut,
    output reg [0:0] WR,
    output reg [0:0] ResetTrigger,
    output reg [0:0] SaveTemp,
    output reg [2:0] MemToReg,
    output reg [2:0] SizeHandler,
    output reg [0:0] IRWrite,
    output reg [0:0] ExceptionAdress,
    output reg [0:0] DataSource,
    output reg [0:0] EPCWrite,
    output reg [1:0] RegDest,
    output reg [0:0] RegWrite,
    output reg [0:0] ALUSrcA,
    output reg [2:0] ALUSrcB,
    output reg [4:0] ControlType,
    output reg [2:0] PCSource,
    output reg [1:0] SLLSourceA,
    output reg [1:0] SLLSourceB,
    output reg [2:0] ShiftType
);

    integer opint;
    always @(*) begin
        opint = opcode;
        
        if(opint == 0) // tipo R
        begin 
            case(funct)
                6'd19:  // rte
                    begin 

                        PCSource = 3'd4;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1; 
                        PCWriteCond = 1'd0;

                    end

                6'd13:  //break

                    begin

                        ALUSrcA = 1'd0;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd2;
                        PCSource = 3'd1;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1;v
                        PCWriteCond = 1'd0;
                    
                    end
                // ALUSrcA = 1 & ALUSrcB = 000
                
                6'd42:  //slt
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd34:  //sub
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd2;
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd32:  //add
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd1;
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd36:  //and
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd3;
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end
                
                6'd37:  //or
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd2;
                        MemToReg = 2'd0;
                        RegDest = 3'd1;
                        RegWrite = 1'd1;

                    end

                6'd26:  //mult
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;

                    end

                6'd24:  //div
                    begin 
                    
                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;

                    end

                6'd24:  //jr
                    begin 

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd0;
                        ControlType = 5'd0;
                        PCSource = 3'd1;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1;
                        PCWriteCond = 1'd0;
                    
                    end

            endcase

        end
        
        else if (opint == 2 | opint == 3) //tipo j

        begin

            case(opcode)

                6'd2: //j
                    begin

                        PCSource = 3'd0;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1;
                        PCWriteCond = 1'd0;

                    end

                6'd3: //jal
                    begin

                        PCSource = 2'd0;
                        PCWriteCond = 1'd1;
                        PCWrite = 1'd1;
                        PCWriteCond = 1'd0;
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

                    end
                6'd8: //addi
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd1;
                        SrcOut = 3'd3;
                        overflowOp = 1;
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd9: //addiu
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd1;
                        SrcOut = 3'd3;
                        overflowOp = 0;
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd9: //addiu
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd7;
                        SrcOut = 3'd2;
                        MemToReg = 3'd0;
                        RegDest = 3'd0;
                        RegWrite = 1;

                    end
                6'd1: //divm
                    begin

                        ALUSrcA = 1'd1;
                        ALUSrcB = 3'd2;
                        ControlType = 5'd9;

                    end

            endcase

        end

    end
endmodule