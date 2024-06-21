// configurar de acordo, ele tá 4 pra 1 por enquanto, vou deixar 32 bits pq é o tamanho do registrador
module SrcAddrMUX (
    input wire [2:0] sel,
    input wire [31:0] IorD_out,
    input wire [31:0] A,
    input wire [31:0] B,
    output wire [31:0] out
);

    assign out =(sel == 0)? IorD_out :
                (sel == 1)? 32'd253 :
                (sel == 2)? 32'd254 :
                (sel == 3)? 32'd255 :
                (sel == 4)? A :
                (sel == 5)? B : 
                32'b00000000000000000000000000000000;

endmodule