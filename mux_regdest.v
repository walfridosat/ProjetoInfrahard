// input do regdest
module regDestMUX (
    input wire [1:0] regDest,
    input wire [5:0] rt,
    input wire [5:0] rd,
    output reg [5:0] out
);


    always @(*) begin
        case (regDest)
            2'b00: 
                out = rt;
            2'b01:
                out = rd;
            2'b10:
                out = 5'b1111;
            2'b11:
                out = 5b'11101;
            default:
                out = 5b'00000; // Valor padrão
        endcase
    end

endmodule