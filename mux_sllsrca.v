module sllsrcAMUX (
    input wire [1:0] SLLSrcA,
    input wire [31:0] A,
    input wire [31:0] imediato,
    input wire [31:0] B,
    output wire [31:0] out
);

    assign out =  (SLLSrcA == 0)? A :
                (SLLSrcA == 1)? imediato :
                (SLLSrcA == 2)? B :
                32'hxxxxxxxx;

endmodule