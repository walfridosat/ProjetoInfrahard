module aluSrcBMUX(
    input wire [2:0] alusrcb,
    input wire [31:0] b,
    input wire [31:0] sign_extend,
    input wire [31:0] sign_extend_sl2,
    input wire [31:0] memorydataregister,
    output wire [31:0] out
);

    assign out =  (alusrcb == 0)? b :
                (alusrcb == 1)? 32'd4 :
                (alusrcb == 2)? sign_extend :
                (alusrcb == 3)? sign_extend_sl2 :
                (alusrcb == 4)? memorydataregister :
                32'b00000000000000000000000000000000;

endmodule