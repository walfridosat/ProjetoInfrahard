// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUXSrcAddr (
    input wire [2:0] sel,
    input wire [31:0] IorD_out,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] out
);


// os outs estão selecionados em ordem dos inputs, o primeiro input (mem) vai ser a saida do primeiro caso (sel = 0...)
    always @(*) begin
        case (sel)
            3'b000: 
                out = IorD_out;
            3'b001:
                out = 32'd253;
            3'b010:
                out = 32'd254;
            3'b011:
                out = 32'd255;
            3'b101:
                out = A;
            3'b110:
                out = B;
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule