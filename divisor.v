module divisor(
    input wire clk,
    input wire [0:0] divOp,
    input wire [31:0] dividend,  
    input wire [31:0] divisor,   
    output reg [31:0] div_hi, 
    output reg [31:0] div_lo,
    output wire divby0flag
);

    integer cima;
    integer baixo;
    integer i;

    assign divby0flag = (divisor == 0) & divOp;
    
    always @(posedge clk) begin
        if(divOp == 1'b1)
        begin
            
            if(i == 31) 
            begin
                cima = 32'd0;
                baixo = divisor;
            end

            // for (i = 31; i >= 0; i = i - 1) 
            if(i >= 0)
            begin
                div_lo = div_lo << 1;
                cima = cima << 1;
                if (dividend[i] == 1) 
                begin
                    cima[0] = 1;
                end

                if (cima >= baixo) 
                begin
                    div_lo = div_lo + 1;
                    cima = cima - baixo;
                end
            end

            if(i == 0) 
            begin
                div_hi = cima;
            end

            i = i - 1;
                
        end else 
        begin
            div_lo = 32'd0;
            div_hi = 32'd0;
            i = 31;
        end
    end
endmodule