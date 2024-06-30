module divisor(
    input wire clk,
    input wire [0:0] divOp,
    input wire [31:0] dividend,  
    input wire [31:0] divisor,   
    output reg [31:0] div_lo, 
    output reg [31:0] div_hi,
    output wire divby0flag
);

    integer cima;
    integer baixo;
    integer i;
    integer divd;
    integer divs;

    assign divby0flag = (divisor == 0) & divOp;
    
    always @(posedge clk) begin
        if(divOp == 1'b1)
        begin
            
            if(i == 31) 
            begin
                cima = 32'd0;

                divd = dividend;
                divs = divisor;

                if(dividend[31] == 1'b1) 
                begin
                    divd = -dividend;
                    divs = -divisor;
                end

                baixo = divs;
            end

            // for (i = 31; i >= 0; i = i - 1) 
            if(i >= 0)
            begin
                div_lo = div_lo << 1;
                cima = cima << 1;


                if(baixo > 0) 
                begin
                    if (divd[i] == 1) cima[0] = 1;
                    
                    if (cima >= baixo) 
                    begin 
                        cima = cima - baixo;
                        div_lo = div_lo + 1;
                    end
                end
                if(baixo < 0)
                begin
                        if (divd[i] == 1) cima[0] = 1;

                        if (cima >= -baixo) 
                        begin
                            cima = cima + baixo;
                            div_lo = div_lo - 1;
                        end
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
            divs = 0;
            divd = 0;
        end
    end
endmodule