module sllsrcBMUX (
    input wire [1:0] SLLSrcB,
    input wire [4:0] B,
    input wire [4:0] Instruction,
    output wire [4:0] out
);

    assign out =  (SLLSrcB == 0)? B :
                (SLLSrcB == 1)? 5'b10000 :
                (SLLSrcB == 2)? Instruction :
                (SLLSrcB == 3)? 5'b00000 :
                5'b00000;

endmodule