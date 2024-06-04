module opcodelogic (
    input wire [5:0] opcode
);

    integer opint;
    always @(*) begin
        opint = opcode;

        if(opint == 0) // tipo R
        
        begin 

            case(funct)


            


            endcase

        end
        
        else if (opint == 2 | opint == 3) //tipo j

        begin

            case(opcode)
                6'd0:
                    PCSource = 2'd0;
                    PCWrite = 1'd1;
                6'd1:
                    PCSource = 2'd0;
                    PCWrite = 1'd1;
                    RegDest = 3'd2;
                    MemToReg = 3'd4;
                    MemWrite = 1'd1;
            endcase

        end

        else //tipo i

        begin

            

        end

    end
endmodule