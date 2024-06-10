// mux do memtoreg
module memToRegMUX (
    input wire [2:0] memtoreg,
    input wire [31:0] AluOut,
    input wire [31:0] memorydataregister,
    input wire [31:0] exceptionadress,
    input wire [31:0] pc,
    output wire [31:0] out
);

    assign out =  (memtoreg == 0)? AluOut :
                (memtoreg == 1)? memorydataregister :
                (memtoreg == 2)? 32'd227 :
                (memtoreg == 3)? exceptionadress :
                (memtoreg == 4)? pc :
                32'b00000000000000000000000000000000;

endmodule