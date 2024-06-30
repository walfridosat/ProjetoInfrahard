module aluSrcAMUX(
    input wire [1:0] sel,
    input wire [31:0] pc,
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] out
);

    assign out =(sel == 0)? pc :
                (sel == 1)? a :
                (sel == 2)? b :
                32'b00000000000000000000000000000000;

endmodule