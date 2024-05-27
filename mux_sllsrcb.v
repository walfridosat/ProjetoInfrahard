module MUX (
    input wire [1:0] SLLSrcB,
    input wire [4:0] B,
    input wire [4:0] Instruction,
    output reg [4:0] out
);


    always @(*) begin
        case (SLLSrcB)
            2'b00: 
                out = B;
            2'b01:
                out = 5'b10000;
            2'b10:
                out = Instruction;
            default:
                out = 5'b00000;
        endcase
    end

endmodule