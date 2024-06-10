module sizehandlerMUX (
    input wire [2:0] sel,
    input wire [31:0] mem,
    input wire [31:0] B,
    output wire [31:0] out
);
    reg[31:0] out_temp = 32'b00000000000000000000000000000000;

    always @(sel) begin
        case (sel)
            3'b000: //sb
                out_temp = {B[7:0], mem[15:8], mem[23:16], mem[31:24]};
            3'b001://sw
                out_temp = {B[7:0], B[15:8], B[23:16], B[31:24]};
            3'b010: // sh
                out_temp = {B[7:0], B[15:8], mem[23:16], mem[31:24]};
            3'b011: // lb
                out_temp = {mem[7:0], 8'b00000000, 8'b00000000, 8'b00000000};
            3'b100: // lw
                out_temp = {mem[7:0], mem[15:8], mem[23:16], mem[31:24]};
            3'b101: // lh
                out_temp = {mem[7:0], mem[15:8], 8'b00000000, 8'b00000000};
            default:
                out_temp = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end

    assign out = out_temp;

endmodule