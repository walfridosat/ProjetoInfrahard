module conditionHandlerMUX(
    input wire [1:0] CondType,
    input wire [0:0] NE,
    input wire [0:0] EQ,
    input wire [0:0] LE,
    input wire [0:0] GT,
    output wire [0:0] out
);

    assign out =  (CondType == 0)? NE :
                (CondType == 1)? EQ :
                (CondType == 2)? LE :
                (CondType == 3)? GT :
                1'b0;
                
endmodule