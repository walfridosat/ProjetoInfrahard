// mux do memtoreg
module memToRegMUX (
    input wire [2:0] memtoreg,
    input wire [31:0] AluOut,
    input wire [31:0] memorydataregister,
    input wire [31:0] exceptionadress,
    input wire [31:0] pc,
    output reg [31:0] out
);

    always @(*) begin
        case (memtoreg)
            3'b000: 
                out = AluOut;
            3'b001:
                out = memorydataregister;
            3'b010:
                out = 32'd227;
            3'b011:
                out = exceptionadress;
            3'b100:
                out = pc;
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule