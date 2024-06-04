module ALUControl (
    input wire [4:0] controlType,
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
            5'b00000:
                begin
                    ALUOp = 3'b000;
                    SrcOut = 3'b011;
                end
            5'b00001:
                begin
                    ALUOp = 3'b001;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            5'b00010:
                begin
                    ALUOp = 3'b010;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            5'b00011:
                begin
                    ALUOp = 3'b011;
                    SrcOut = 3'b011;
                end
            5'b00100:
                begin
                    ALUOp = 3'b100;
                    overflowOp = 1'b1;
                    SrcOut = 3'b011;
                end
            5'b00101:
                begin
                    ALUOp = 3'b101;
                    SrcOut = 3'b011;
                end
            5'b00110:
                begin
                    ALUOp = 3'b110;
                    SrcOut = 3'b011;
                end
            5'b00111:
                begin
                    ALUOp = 3'b111;
                    SrcOut = 3'b010;
                end
            5'b01000:
                begin
                    orOp = 1'b1;
                    SrcOut = 3'b100;
                end
            5'b01001:
                divOp = 1'b1;
            5'b01010:
                multOp = 1'b1;
            5'b01011:
                begin
                    ALUOp = 3'b001;
                    SrcOut = 3'b011;
                end
            5'b01100:
                SrcOut = 3'b001;
            5'b01101:
                SrcOut = 3'b000;
            5'b01110:
                condType = 2'b00;
            5'b01111:
                condType = 2'b01;
            5'b10000:
                condType = 2'b10;
            5'b10001:
                condType = 2'b11;

        endcase
    end

endmodule