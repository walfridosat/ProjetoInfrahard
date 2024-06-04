// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUXIorD (
    input wire [0:0] sel,
    input wire [31:0] PC,
    input wire [31:0] AluOut,
    output reg [31:0] out
);


// os outs estão selecionados em ordem dos inputs, o primeiro input (mem) vai ser a saida do primeiro caso (sel = 0...)
    always @(*) begin
        case (sel)
            2'b00: 
                out = PC;
            2'b01:
                out = AluOut;
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule