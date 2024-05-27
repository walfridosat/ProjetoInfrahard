
module multiplicador(
    input wire [0:0] multOp,
    input wire [31:0] multiplicand,
    input wire [31:0] multiplier,
    output reg [31:0] out_high,
    output reg [31:0] out_low
);

reg [32:0] A; 
reg [32:0] Q; 
reg Q_1;    

always @(posedge multOp) begin
    A = {1'b0, multiplicand}; 
    Q = {1'b0, multiplier};    
    Q_1 = 1'b0;              
    
    for (integer i = 0; i < 32; i = i + 1) begin

        case ({Q[0], Q_1})
            2'b01: begin 
                A = A + multiplicand;
            end
            2'b10: begin 
                A = A - multiplicand;
            end
            default: begin 
            end
        endcase

        {A, Q, Q_1} = {A[31], A, Q};
    end


    out_high = A;
    out_low = Q;
end

endmodule

