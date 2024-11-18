module top (
    // Inputs for mux_A
    input [7:0] ADD_A,
    input [7:0] SUB_A,
    input [7:0] SHL_A,
    input [7:0] SHR_A,
    input [7:0] CMP_A,
    input [7:0] AND_A,
    input [7:0] OR_A,
    input [7:0] XOR_A,
    input [7:0] NAND_A,
    input [7:0] NOR_A,
    input [7:0] XNOR_A,
    input [7:0] NOT_A,
    input [7:0] INV_A,
    input [7:0] NEG_A,
    input [7:0] STO_A,
    input [7:0] SWP_A,
    input [7:0] LOAD_A,
    input [3:0] sel_A,
    input enable_A,

    // Inputs for mux_B
    input [7:0] ADD_B,
    input [7:0] SUB_B,
    input [7:0] SHL_B,
    input [7:0] SHR_B,
    input [7:0] CMP_B,
    input [7:0] AND_B,
    input [7:0] OR_B,
    input [7:0] XOR_B,
    input [7:0] NAND_B,
    input [7:0] NOR_B,
    input [7:0] XNOR_B,
    input [7:0] NOT_B,
    input [7:0] INV_B,
    input [7:0] NEG_B,
    input [7:0] STO_B,
    input [7:0] SWP_B,
    input [7:0] LOAD_B,
    input [3:0] sel_B,
    input enable_B,

    // Inputs for mux_Y
    input [7:0] ADD_Y,
    input [7:0] SUB_Y,
    input [7:0] SHL_Y,
    input [7:0] SHR_Y,
    input [7:0] CMP_Y,
    input [7:0] AND_Y,
    input [7:0] OR_Y,
    input [7:0] XOR_Y,
    input [7:0] NAND_Y,
    input [7:0] NOR_Y,
    input [7:0] XNOR_Y,
    input [7:0] NOT_Y,
    input [7:0] INV_Y,
    input [7:0] NEG_Y,
    input [7:0] STO_Y,
    input [7:0] SWP_Y,
    input [7:0] LOAD_Y,
    input [3:0] sel_Y,
    input enable_Y,

    // Clock and reset
    input clk,
    input reset,

    // Outputs
    output reg [7:0] A,
    output reg [7:0] B,
    output reg [7:0] Y
);

    // Intermediate wires
  wire [7:0] mux_A_data;
  wire [7:0] mux_B_data;
  wire [7:0] mux_Y_data;

    // Instantiate mux_A
    mux mux_A (
        .ADD(ADD_A), 
      .SUB(SUB_A), 
      .SHL(SHL_A), 
      .SHR(SHR_A),
        .CMP(CMP_A), 
      .AND(AND_A), 
      .OR(OR_A), 
      .XOR(XOR_A),
        .NAND(NAND_A), 
      .NOR(NOR_A), 
      .XNOR(XNOR_A), 
      .NOT(NOT_A),
        .INV(INV_A), 
      .NEG(NEG_A), 
      .STO(STO_A), 
      .SWP(SWP_A),
        .LOAD(LOAD_A), 
      .sel(sel_A), 
      .enable(enable_A),
      .data(mux_A_data)
    );

    // Instantiate mux_B
    mux mux_B (
        .ADD(ADD_B), 
      .SUB(SUB_B), 
      .SHL(SHL_B), 
      .SHR(SHR_B),
        .CMP(CMP_B), 
      .AND(AND_B), 
      .OR(OR_B), 
      .XOR(XOR_B),
        .NAND(NAND_B), 
      .NOR(NOR_B), 
      .XNOR(XNOR_B), 
      .NOT(NOT_B),
        .INV(INV_B), 
      .NEG(NEG_B), 
      .STO(STO_B), 
      .SWP(SWP_B),
        .LOAD(LOAD_B), 
      .sel(sel_B), 
      .enable(enable_B),
      .data(mux_B_data)
    );

    // Instantiate mux_Y
    mux mux_Y (
        .ADD(ADD_Y), 
      .SUB(SUB_Y), 
      .SHL(SHL_Y), 
      .SHR(SHR_Y),
        .CMP(CMP_Y), 
      .AND(AND_Y), 
      .OR(OR_Y), 
      .XOR(XOR_Y),
        .NAND(NAND_Y), 
      .NOR(NOR_Y), 
      .XNOR(XNOR_Y), 
      .NOT(NOT_Y),
        .INV(INV_Y), 
      .NEG(NEG_Y), 
      .STO(STO_Y), 
      .SWP(SWP_Y),
        .LOAD(LOAD_Y), 
      .sel(sel_Y), 
      .enable(enable_Y),
      .data(mux_Y_data)
    );

    // Registers for A, B, and Y
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;
        end else begin
            A <= data_from_mux_A;
            B <= data_from_mux_B;
            Y <= data_from_mux_Y;
        end
    end

endmodule
