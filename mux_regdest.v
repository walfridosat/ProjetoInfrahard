// input do regdest
module regDestMUX (
    input wire [1:0] sel,
    input wire [5:0] rt,
    input wire [5:0] rd,
    output wire [5:0] out
);

    assign out =(sel == 0)? rt :
                (sel == 1)? rd :
                (sel == 2)? 5'b11111 :
                (sel == 3)? 5'b11101 :
                5'b00000;

endmodule