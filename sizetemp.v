module tempReg (
    input wire [0:0] SaveTemp,
    input wire [31:0] save,
    output reg [31:0] temp
);

    always @(posedge SaveTemp) begin

        temp = save;

    end

endmodule