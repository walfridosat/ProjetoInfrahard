module sign_extender16_32(
    input wire [15:0] data, 
    output wire [31:0] data_extended
);
    assign data_extended = {{16{data[15]}}, data[15:0]};

endmodule