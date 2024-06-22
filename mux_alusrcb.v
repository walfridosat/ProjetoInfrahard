module aluSrcBMUX(
    input wire [2:0] sel,
    input wire [31:0] b,
    input wire [31:0] sign_extend,
    input wire [31:0] sign_extend_sl2,
    input wire [31:0] memorydataregister,
    output wire [31:0] out
);

    assign out =(sel == 0)? b :
                (sel == 1)? 32'd4 :
                (sel == 2)? sign_extend :
                (sel == 3)? sign_extend_sl2 :
                (sel == 4)? memorydataregister :
                32'b00000000000000000000000000000000;

endmodule