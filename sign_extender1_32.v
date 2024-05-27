module sign_extender1_32(
    input wire data, 
    output reg [31:0] data_extended
);
    always @(*) begin
      data_extended <= {{31{1'b0}}, data};
    end
endmodule