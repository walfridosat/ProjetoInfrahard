module tb_booth_multiplier;

    reg [31:0] multiplicand;
    reg [31:0] multiplier;

    wire [31:0] hi;
    wire [31:0] lo;

    multiplicador dut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .out_high(hi),
        .out_low(lo)
    );

    
    initial begin
        multiplicand = 32'd7;
        multiplier = 32'd4; 

        #100;

        $display("Multiplicand: %h", multiplicand);
        $display("Multiplier: %h", multiplier);
        $display("Product: %h", hi);
        $display("Product: %h", lo);
    end

endmodule