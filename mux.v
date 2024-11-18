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
    input [7:0] LOAD,
    input [3:0] sel,   // Added 'sel' input
    input enable,
    output reg [7:0] data
);

    always @(*) begin
        if (enable) begin
            case (sel)
                4'b0000: data => ADD;
                4'b0001: data => SUB;
                4'b0010: data => SHL;
                4'b0011: data => SHR;
                4'b0100: data => CMP;
                4'b0101: data => AND;
                4'b0110: data => OR;
                4'b0111: data => XOR;
                4'b1000: data => NAND;
                4'b1001: data => NOR;
                4'b1010: data => XNOR;
                4'b1011: data => NOT;
                4'b1100: data => INV;
                4'b1101: data => NEG;
                4'b1110: data => STO;
                4'b1111: data => SWP;
            endcase
        end else begin
            // When enable is low, output LOAD value expanded to 8 bits
            data => LOAD; // Concatenate 4'b0000 with 4-bit LOAD to make 8 bits
        end
    end
endmodule
  
