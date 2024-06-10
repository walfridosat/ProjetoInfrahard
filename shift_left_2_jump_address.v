module ShiftLeftTwoJump(
    input wire [25:0] Instruction,
    input wire [3:0] PC,
    output wire [31:0] out,
    output wire [27:0] y
);

    assign y = {{2'b00}, Instruction} << 2;
    assign out = {PC, y};

endmodule