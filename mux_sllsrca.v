module sllsrcAMUX (
    input wire [1:0] sel,
    input wire [31:0] A,
    input wire [31:0] imediato,
    input wire [31:0] B,
    output wire [31:0] out
);

    assign out =(sel == 0)? A :
                (sel == 1)? imediato :
                (sel == 2)? B :
                32'hxxxxxxxx;

endmodule