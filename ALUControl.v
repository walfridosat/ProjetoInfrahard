module ALUControl (
    input wire [3:0] controlType,
    output reg [1:0] condType,
    output reg [0:0] divOp,
    output reg [0:0] multOp,
    output reg [2:0] ALUOp,
    output reg [0:0] orOp,
    output reg [0:0] overflowOp,
    output reg [2:0] SrcOut
);

    always @(*) begin
        condType = 2'b00;
        divOp = 1'b0;
        multOp = 1'b0;
        ALUOp = 3'b000;
        orOp = 1'b0;
        overflowOp = 1'b0;
        SrcOut = 3'b000;
        
        case (controlType)
            4'b0000:
                begin
                    ALUOp = 3'b000;
                    SrcOut = 3'b011;
                end
            4'b0001:
                begin
                    ALUOp = 3'b001;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            4'b0010:
                begin
                    ALUOp = 3'b010;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            4'b0011:
                begin
                    ALUOp = 3'b011;
                    SrcOut = 3'b011;
                end
            4'b0100:
                begin
                    ALUOp = 3'b100;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            4'b0101:
                begin
                    ALUOp = 3'b101;
                    SrcOut = 3'b011;
                end
            4'b0110:
                begin
                    ALUOp = 3'b110;
                    SrcOut = 3'b011;
                end
            4'b0111:
                begin
                    ALUOp = 3'b111;
                    SrcOut = 3'b010;
                end
            4'b1000:
                begin
                    orOp = 1'b1;
                    SrcOut = 3'b100;
                end
            4'b1001:
                divOp = 1'b1;
            4'b1010:
                multOp = 1'b1;
            4'b1011:
                begin
                    ALUOp = 3'b001;
                    SrcOut = 3'b011;
                end
            4'b1100:
                SrcOut = 3'b001;
            4'b1101:
                SrcOut = 3'b000;

        endcase
    end

endmodule