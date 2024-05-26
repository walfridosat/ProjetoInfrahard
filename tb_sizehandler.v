module testbench_sizehandlerMUX;
    reg [2:0] sel;
    reg [31:0] mem;
    reg [31:0] B;
    wire [31:0] out;

    // Instancie o módulo sizehandlerMUX
    sizehandlerMUX dut (
        .sel(sel),
        .mem(mem),
        .B(B),
        .out(out)
    );

    initial begin
        // Teste 1: sb
        sel = 3'b000;
        mem = 32'b00000000000000000000000000000000;
        B = 32'b11111111111111111111111111111111;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", out);

        // Teste 2: sw
        sel = 3'b001;
        mem = 32'b00000000000000000000000000000000;
        B = 32'b11111111111111111111111111111111;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sw): %b", out);

        // Teste 1: sh
        sel = 3'b010;
        mem = 32'b00000000000000000000000000000000;
        B = 32'b11111111111111111111111111111111;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sh): %b", out);
        
        $finish; 
    end
endmodule

