module conditionHandlerMUX(
    input wire [1:0] CondType,
    input wire [0:0] NE,
    input wire [0:0] EQ,
    input wire [0:0] LE,
    input wire [0:0] GT,
    output reg [0:0] out
);

    always @(*) begin
        case (CondType)
            2'b00:
                out = NE;
            2'b01:
                out = EQ;
            2'b10:
                out = LE;
            2'b11:
                out = GT;
            default:
                out = 1'b0; // Valor padrão
        endcase
    end

endmodule