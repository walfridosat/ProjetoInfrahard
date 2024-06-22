// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUX32 (
    input  wire sel,
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [31:0] out
);

    assign out =(sel == 0)? A :
                (sel == 1)? B :
                32'b00000000000000000000000000000000;

endmodule