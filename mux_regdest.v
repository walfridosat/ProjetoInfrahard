// input do regdest
module regDestMUX (
    input wire [1:0] regDest,
    input wire [5:0] rt,
    input wire [5:0] rd,
    output wire [5:0] out
);

    assign out =  (regDest == 0)? rt :
                (regDest == 1)? rd :
                (regDest == 2)? 5'b11111 :
                (regDest == 3)? 5'b11101 :
                5'b00000;

endmodule