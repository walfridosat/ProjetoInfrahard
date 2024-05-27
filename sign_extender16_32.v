
module sign_extender16_32(
    input wire [15:0] data, 
    output reg [32:0] data_extended
);
    always @(*) begin
      data_extended <= {{16{data[15]}}, data[15:0]};
    end
endmodule