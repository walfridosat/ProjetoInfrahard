module pcSourceMUX (
    input wire [2:0] PCSource,
    input wire [31:0] jumpAdress,
    input wire [31:0] result,
    input wire [31:0] aluOut,
    input wire [31:0] memData,
    input wire [31:0] EPCReg,
    output reg [31:0] out
);


    always @(*) begin
        case (PCSource)
            3'b000: 
                out = jumpAdress;
            3'b001:
                out = result;
            3'b010:
                out = aluOut;
            3'b011:
                out = memData;
            3'b100:
                out = EPCReg;
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule