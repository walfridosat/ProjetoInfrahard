module lo (
    input wire [1:0] StoreMD,
    input wire [31:0] mult_lo,
    input wire [31:0] div_lo,
    output reg [31:0] lo
);

    always @(StoreMD) begin

        case (StoreMD) 
            2'b01:
                lo = div_lo;
            2'b10:
                lo = mult_lo;
        endcase

    end

endmodule