module divisor(
    input wire [0:0] divOp,
    input wire [31:0] dividend,  
    input wire [31:0] divisor,   
    output reg [31:0] hi, 
    output reg [31:0] lo 
);

    integer cima;
    integer baixo;
    integer i;
    
    always @(posedge divOp) begin
        hi = 32'd0;
        lo = 32'd0;

        cima = 32'd0;
        baixo = divisor;

        for (i = 31; i >= 0; i = i - 1) begin
            hi = hi << 1;
            cima = cima << 1;
            if (dividend[i] == 1) begin
                cima[0] = 1;
            end

            if (cima >= baixo) begin
                hi = hi + 1;
                cima = cima - baixo;
            end

        end

        lo = cima;
    end
endmodule

module testbench_divisor;
    reg [0:0] divOp;
    reg [31:0] dividend;
    reg [31:0] divisor;
    wire [31:0] hi;
    wire [31:0] lo;

    // Instancie o módulo sizehandlerMUX
    divisor dut (
        .divOp(divOp),
        .dividend(dividend),
        .divisor(divisor),
        .hi(hi),
        .lo(lo)
    );

    initial begin
        // Teste 1: sb
        divOp = 3'b1;
        dividend = 32'd2;
        divisor = 32'd2;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", hi, " ", lo);
        
        divOp = 3'b0;

        // Teste 2: sw
        divOp = 3'b1;
        dividend = 32'd20;
        divisor = 32'd4;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", hi, " ", lo);

        divOp = 3'b0;

        // Teste 1: sh
        divOp = 3'b1;
        dividend = 32'd101;
        divisor = 32'd10;
        #10; // Aguarde 10 unidades de tempo
        $display("Resultado (sb): %b", hi, " ", lo);
        
        $finish; 
    end
endmodule

