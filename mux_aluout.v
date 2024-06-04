module aluOutMUX (
    input wire [2:0] SrcOut,
    input wire [31:0] Lo,
    input wire [31:0] Hi,
    input wire [31:0] LT,
    input wire [31:0] result,
    input wire [31:0] orOut,
    input wire [31:0] shiftOut,
    output reg [31:0] out
);


    always @(*) begin
        case (SrcOut)
            3'b000: 
                out = Lo;
            3'b001:
                out = Hi;
            3'b010:
                out = LT;
            3'b011:
                out = result;
            3'b100:
                out = orOut;
            3'b101:
                out = shiftOut;
                
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule