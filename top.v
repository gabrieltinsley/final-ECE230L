module top
#(
    parameter BIT_COUNT = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [15:8] sw, // A 
    input [3:0] sel,
    input btnC, // clock
    input btnU, // reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
    output [15:0] led
    
);

    // Instantiate the clock divider...
    // ... wire it up to the scanner
    // ... wire the scanner to the decoder

    // Wire up the math block into the decoder

    // Do not forget to wire up resets!!
    // Clock divider output
    wire div_clock;
    
    // Instantiate the clock divider
    clock_div #(.DIVIDE_BY(BIT_COUNT)) clk_div_inst (
        .clock(btnC),
        .reset(btnU),
        .div_clock(div_clock)
    );


    // Math block outputs
    // Split switches into two 4-bit signals A and B
    wire [3:0] lowerY;
    wire [3:0] upperY;

    // Intermediate wires
    wire [7:0] data_from_mux_A;
    wire [7:0] data_from_mux_B;
    wire [7:0] data_from_mux_Y;

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
        .data(data_from_mux_A)
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
        .data(data_from_mux_B)
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
        .data(data_from_mux_Y)
    );


    // Instantiate the 7-segment scanner (to cycle through the anodes)
    seven_seg_scanner scanner_inst (
        .div_clock(div_clock),
        .reset(btnU),
        .anode(an)
    );


    // Instantiate the seven-segment decoder
    seven_seg_decoder decoder_inst (
        .Val(sw[3:0]),
        .lowerY(lowerY),
        .upperY(upperY),
        .anode(an),
        .segs(seg)
    );


endmodule
