// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUX (
    input wire [1:0] sel,
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    output wire [31:0] out
);

    assign out =  (sel == 0)? in0 :
                (sel == 1)? in1 :
                (sel == 2)? in2 :
                (sel == 3)? in3 :
                32'b00000000000000000000000000000000;

endmodule