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
    output reg [7:0] A,
    output reg [7:0] B,
    output reg [7:0] Y
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

    // add a bunch of wires 8-bit wide to do all the operations
    wire [7:0] AaddB;

    ADD op0 (
        .A(A),
        .B(B),
        .Y(AaddB)
    );
    
    wire [7:0] AsubB;

    SUB op1 (
        .A(A),
        .B(B),
        .Y(AsubB)
    );

    wire [7:0] AcmpB;

    CMP op2 (
        .A(A),
        .B(B),
        .Y(AcmpB)
    );
    
    wire [7:0] AshlB;

    SHL op3 (
        .A(A),
        .B(B),
        .Y(AshlB)
    );
    
    wire [7:0] AshrB;
    
    SHR op4 (
        .A(A),
        .B(B),
        .Y(AshrB)
    );
    
    wire [7:0] AandB;

    AND op5 (
        .A(A),
        .B(B),
        .Y(AandB)
    );
    
    wire [7:0] AorB;

    OR op6 (
        .A(A),
        .B(B),
        .Y(AorB)
    );
    
    wire [7:0] AxorB;
    
    XOR op7 (
        .A(A),
        .B(B),
        .Y(AxorB)
    );
    
    wire [7:0] AnandB;

    NAND op8 (
        .A(A),
        .B(B),
        .Y(AnandB)
    );
    
    wire [7:0] AnorB;

    NOR op9 (
        .A(A),
        .B(B),
        .Y(AnorB)
    );
    
    wire [7:0] AxnorB;

    XNOR op10 (
        .A(A),
        .B(B),
        .Y(AxnorB)
    );
    
    wire [7:0] AinvB;

    INV op11 (
        .A(A),
        .B(B),
        .Y(AinvB)
    );
    
    wire [7:0] AnegB;

    NEG op12 (
        .A(A),
        .B(B),
        .Y(AnegB)
    );
    
    wire [7:0] Asto;

    STO op13 (
        .A(A),
        .store(btnC),
        .Y(Asto)
    );
    
    wire [7:0] AswpB;

    SWP op14 (
        .clk(btnC),
        .swap(btnU),
        .A(A),
        .B(B)
    );
    
    wire [7:0] Aload;

    LOAD op15 (
        .A(A),
        .clock(btnC),
        .load(btnU),
        .switches(sw[15:8])
    );

    // Split switches into two 4-bit signals lowerY and upperY
    wire [3:0] lowerY;
    wire [3:0] upperY;

    // Intermediate wires
    wire [7:0] Aout;
    wire [7:0] Bout;
    wire [7:0] Yout;

    // Instantiate mux_A
    mux mux_A (
        .ADD(A), 
        .SUB(A), 
        .SHL(Ashl), 
        .SHR(SHR_A),
        .CMP(CMP_A), 
        .AND(AND_A), 
        .OR(OR_A), 
        .XOR(XOR_A),
        .NAND(NAND_A), 
        .NOR(NOR_A), 
        .XNOR(XNOR_A), 
        .INV(INV_A), 
        .NEG(NEG_A), 
        .STO(STO_A), 
        .SWP(SWP_A),
        .LOAD(LOAD_A), 
        .sel(sel_A),
        .enable(btnC),
        .data(Aout)
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
        .INV(INV_B), 
        .NEG(NEG_B), 
        .STO(STO_B), 
        .SWP(SWP_B),
        .LOAD(LOAD_B), 
        .sel(sel_B),
        .enable(btnC),
        .data(Bout)
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
        .INV(INV_Y), 
        .NEG(NEG_Y), 
        .STO(STO_Y), 
        .SWP(SWP_Y),
        .LOAD(LOAD_Y), 
        .sel(sel_Y), 
        .enable(btnC),
        .data(Yout)
    );


    // Instantiate the 7-segment scanner (to cycle through the anodes)
    seven_seg_scanner scanner_inst (
        .div_clock(div_clock),
        .reset(btnU),
        .anode(an)
    );


    // Instantiate the seven-segment decoder
    seven_seg_decoder decoder_inst (
        .Val(sw[15:8]),
        .lowerY(lowerY),
        .upperY(upperY),
        .anode(an),
        .segs(seg)
    );

     // Registers for A, B, and Y
    always @(posedge btnC, posedge btnU) begin
        if (btnU) begin
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;
        end else begin
            A <= Aout;
            B <= Bout;
            Y <= Yout;
        end
    end



endmodule
