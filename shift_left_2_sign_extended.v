module ShiftLeftTwoSign(
    input wire [1:0] data,
    output wire [31:0] out
);

    assign out = data << 2;
                
endmodule