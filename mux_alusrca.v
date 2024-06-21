module aluSrcAMUX(
    input wire alusrca,
    input wire [31:0] pc,
    input wire [31:0] a,
    output wire [31:0] out
);

    assign out =(alusrca == 0)? pc :
                (alusrca == 1)? a :
                32'b00000000000000000000000000000000;

endmodule