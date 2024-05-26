// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUX (
    input wire [1:0] sel,
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    output reg [31:0] out
);


// os outs estão selecionados em ordem dos inputs, o primeiro input (mem) vai ser a saida do primeiro caso (sel = 0...)
    always @(*) begin
        case (sel)
            2'b00: 
                out = in0;
            2'b01:
                out = in1;
            2'b10:
                out = in2;
            2'b11:
                out = in3;
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

endmodule