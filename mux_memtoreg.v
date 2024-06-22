// mux do memtoreg
module memToRegMUX (
    input wire [2:0] sel,
    input wire [31:0] AluOut,
    input wire [31:0] memorydataregister,
    input wire [31:0] exceptionadress,
    input wire [31:0] pc,
    output wire [31:0] out
);

    assign out =(sel == 0)? AluOut :
                (sel == 1)? memorydataregister :
                (sel == 2)? 32'd227 :
                (sel == 3)? exceptionadress :
                (sel == 4)? pc : 32'b00000000000000000000000000000000;

endmodule