module sllsrcBMUX (
    input wire [1:0] sel,
    input wire [4:0] B,
    input wire [4:0] Instruction,
    output wire [4:0] out
);

    assign out =(sel == 0)? B :
                (sel == 1)? 5'b10000 :
                (sel == 2)? Instruction :
                (sel == 3)? 5'b00000 :
                5'b00000;

endmodule