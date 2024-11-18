module mux (
    input [7:0] ADD,
    input [7:0] SUB,
    input [7:0] SHL,
    input [7:0] SHR,
    input [7:0] CMP,
    input [7:0] AND,
    input [7:0] OR,
    input [7:0] XOR,
    input [7:0] NAND,
    input [7:0] NOR,
    input [7:0] XNOR,
    input [7:0] NOT,
    input [7:0] INV,
    input [7:0] NEG,
    input [7:0] STO,
    input [7:0] SWP,
    input [3:0] LOAD,
    input [3:0] sel,   // Added 'sel' input
    input enable,
    output reg [7:0] Y
);

    always @(*) begin
        if (enable) begin
            case (sel)
                4'b0000: Y = ADD;
                4'b0001: Y = SUB;
                4'b0010: Y = SHL;
                4'b0011: Y = SHR;
                4'b0100: Y = CMP;
                4'b0101: Y = AND;
                4'b0110: Y = OR;
                4'b0111: Y = XOR;
                4'b1000: Y = NAND;
                4'b1001: Y = NOR;
                4'b1010: Y = XNOR;
                4'b1011: Y = NOT;
                4'b1100: Y = INV;
                4'b1101: Y = NEG;
                4'b1110: Y = STO;
                4'b1111: Y = SWP; // Corrected typo
                default: Y = 8'b00000000; // Optional default case for safety
            endcase
        end else begin
            // When enable is low, output LOAD value expanded to 8 bits
            Y = {4'b0000, LOAD}; // Concatenate 4'b0000 with 4-bit LOAD to make 8 bits
        end
    end
endmodule
  
