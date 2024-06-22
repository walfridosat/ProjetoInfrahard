module Or (
    input wire [31:0] A,
    input wire [31:0] B,
    output wire [31:0] result
);

    assign result = A | B;

endmodule