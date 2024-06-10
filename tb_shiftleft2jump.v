module ShiftLeftTwoJump(
    input wire [25:0] Instruction,
    input wire [3:0] PC,
    output reg [31:0] out,
    output reg [27:0] y
);

    always @(*) begin
        y = {{2'b00}, Instruction};
        y = y << 2;
        out <= {PC, y};

    end

endmodule

module testbench_shiftleft2jump;
    reg [25:0] Instruction;
    reg [3:0] PC;
    wire [31:0] out;
    wire [27:0] y;

    // Instancie o módulo sizehandlerMUX
    ShiftLeftTwoJump dut (
        .Instruction(Instruction),
        .PC(PC),
        .out(out),
        .y(y)
    );

    initial begin
        // Teste 1: sb
        Instruction = 26'b00001000011110101010101010;
        PC = 4'b1110;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", PC, " + ", Instruction, " = ", out);
        $display("olha o x: ", y);

        // Teste 2: sw
        Instruction = 26'd300;
        PC = 4'd7;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", PC, " + ", Instruction, " = ", out);
        $display("olha o x: ", y);

        // Teste 1: sh
        Instruction = 26'd902;
        PC = 4'd7;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", PC, " + ", Instruction, " = ", out);
        $display("olha o x: ", y);
        
        $finish;
    end
endmodule

