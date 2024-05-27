module Or (
    input wire [0:0] orOp,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] result
);

    always @(posedge orOp) begin
        result = A | B;
    end

endmodule