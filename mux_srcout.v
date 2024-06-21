module SrcOutMUX (
    input wire [2:0] SrcOut,
    input wire [31:0] Lo,
    input wire [31:0] Hi,
    input wire [31:0] LT,
    input wire [31:0] result,
    input wire [31:0] orOut,
    input wire [31:0] shiftOut,
    output wire [31:0] out
);

    assign out =(SrcOut == 0)? Lo :
                (SrcOut == 1)? Hi :
                (SrcOut == 2)? LT :
                (SrcOut == 3)? result :
                (SrcOut == 4)? orOut :
                (SrcOut == 5)? shiftOut :
                32'b00000000000000000000000000000000;

endmodule