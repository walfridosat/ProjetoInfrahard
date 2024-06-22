module conditionHandlerMUX(
    input wire [1:0] sel,
    input wire [0:0] NE,
    input wire [0:0] EQ,
    input wire [0:0] LE,
    input wire [0:0] GT,
    output wire [0:0] out
);

    assign out =(sel == 0)? NE :
                (sel == 1)? EQ :
                (sel == 2)? LE :
                (sel == 3)? GT :
                1'b0;
                
endmodule