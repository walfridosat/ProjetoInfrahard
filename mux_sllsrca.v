module MUX (
    input wire [1:0] SLLSrcA,
    input wire [31:0] A,
    input wire [31:0] imediato,
    input wire [31:0] B,
    output reg [31:0] out
);


    always @(*) begin
        case (SLLSrcA)
            2'b00: 
                out = A;
            2'b01:
                out = imediato;
            2'b10:
                out = B;
            default:
                out = 32'b00000000000000000000000000000000;
        endcase
    end

endmodule