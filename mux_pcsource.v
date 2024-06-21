module pcSourceMUX (
    input wire [2:0] PCSource,
    input wire [31:0] jumpAdress,
    input wire [31:0] result,
    input wire [31:0] aluOut,
    input wire [31:0] memData,
    input wire [31:0] EPCReg,
    output wire [31:0] out
);

    assign out =(PCSource == 0)? jumpAdress :
                (PCSource == 1)? result :
                (PCSource == 2)? aluOut :
                (PCSource == 3)? memData :
                (PCSource == 4)? EPCReg :
                32'b00000000000000000000000000000000;

endmodule