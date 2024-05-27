module divisor(
    input wire [0:0] divOp,
    input wire [31:0] dividend,  
    input wire [31:0] divisor,   
    output reg [31:0] hi, 
    output reg [31:0] lo 
);

    integer cima;
    integer baixo;
    
    always @(posedge divOp) begin
        hi = 32'd0;
        lo = 32'd0;

        cima = 32'd0;
        baixo = divisor;

        for (integer i = 31; i >= 0; i = i - 1) begin
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