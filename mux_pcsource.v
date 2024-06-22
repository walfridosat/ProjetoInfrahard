module pcSourceMUX (
    input wire [2:0]  sel,
    input wire [31:0] jumpAdress,
    input wire [31:0] result,
    input wire [31:0] aluOut,
    input wire [31:0] memData,
    input wire [31:0] EPCReg,
    output wire[31:0] out
);

    assign out =(sel == 0)? jumpAdress :
                (sel == 1)? result :
                (sel == 2)? aluOut :
                (sel == 3)? memData :
                (sel == 4)? EPCReg :
                32'b00000000000000000000000000000000;

endmodule