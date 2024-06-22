module aluSrcAMUX(
    input wire sel,
    input wire [31:0] pc,
    input wire [31:0] a,
    output wire [31:0] out
);

    assign out =(sel == 0)? pc :
                (sel == 1)? a :
                32'b00000000000000000000000000000000;

endmodule