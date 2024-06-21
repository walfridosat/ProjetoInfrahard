// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUXIorD (
    input wire [0:0] sel,
    input wire [31:0] PC,
    input wire [31:0] AluOut,
    output wire [31:0] out
);

    assign out =(sel == 0)? PC :
                (sel == 1)? AluOut :
                32'b00000000000000000000000000000000;

endmodule