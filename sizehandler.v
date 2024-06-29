module sizehandlerMUX (
    input wire [2:0] sel,
    input wire [31:0] mem,
    input wire [31:0] B,
    output reg [31:0] out
);

    always @* begin
        case (sel)
            3'b000: // sb
                out = { B [7:0], mem[23:16], mem[15:8], mem[7:0] };
            3'b010: // sh
                out = { B [7:0],  B [15:8],  mem[15:8], mem[7:0]};
            3'b001: // sw
                out = { B [7:0],  B [15:8],   B [23:16],   B [31:24]};
            3'b100: // lw
                out = {mem[7:0], mem[15:8],  mem[23:16],  mem[31:24]};
            3'b101: // lh
                out={8'b00000000,8'b00000000,mem[23:16],  mem[31:24]};
            3'b011: // lb
                out={8'b00000000,8'b00000000,8'b00000000, mem[31:24]};
            3'b111: // rep
                out = {mem[31:24], mem[23:16], mem[15:8], mem[7:0]};
            3'b110: //exeption
                out={8'b00000000,8'b00000000,8'b00000000, mem[7:0]};
            default:
                out = 32'b00000000000000000000000000000000; // Valor padrão
        endcase
    end


endmodule