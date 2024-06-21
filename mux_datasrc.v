// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module MUXDataSrc (
    input wire [0:0] sel,
    input wire [31:0] temp,
    input wire [31:0] size_handler,
    output wire [31:0] out
);

    assign out =(sel == 0)? temp :
                (sel == 1)? size_handler :
                32'b00000000000000000000000000000000;
                
endmodule