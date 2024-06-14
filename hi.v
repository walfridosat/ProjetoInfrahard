module hi (
    input wire [1:0] StoreMD,
    input wire [31:0] mult_hi,
    input wire [31:0] div_hi,
    output reg [31:0] hi
);

    always @(StoreMD) begin

        case (StoreMD) 
            2'b01:
                hi = div_hi;
            2'b10:
                hi = mult_hi;
        endcase

    end

endmodule