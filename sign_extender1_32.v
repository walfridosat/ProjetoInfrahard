module sign_extender1_32(
    input wire data, 
    output wire [31:0] data_extended
);
    
    assign data_extended = {{31{1'b0}}, data};
    
endmodule