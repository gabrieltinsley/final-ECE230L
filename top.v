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
    
    wire [7:0] Ashl;

    SHL op3 (
        .A(A),
        .Y(Ashl)
    );
    
    wire [7:0] Ashr;
    
    SHR op4 (
        .A(A),
        .Y(Ashr)
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
    
    wire [7:0] Ainv;

    INV op11 (
        .A(A),
        .Y(AinvB)
    );
    
    wire [7:0] Aneg;

    NEG op12 (
        .A(A),
        .Y(Aneg)
    );
    
    wire [7:0] Asto;

    STO op13 (
        .A(A),
        .store(btnC),
        .Y(Asto)
    );
    
    wire [7:0] AswpB;

    SWP op14 (
        .clock(btnC),
        .swap(AswpB),
        .A(B),
        .B(A)
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

    assign lowerY = Y[3:0];
    assign upperY = Y[7:4];

    // Intermediate wires
    wire [7:0] Aout;
    wire [7:0] Bout;
    wire [7:0] Yout;

    // Instantiate mux_A
    mux mux_A (
        .ADD(A), 
        .SUB(A), 
        .SHL(Ashl), 
        .SHR(Ashr),
        .CMP(A), 
        .AND(A), 
        .OR(A), 
        .XOR(A),
        .NAND(A), 
        .NOR(A), 
        .XNOR(A), 
        .INV(A), 
        .NEG(A), 
        .STO(Y), 
        .SWP(B),
        .LOAD(A), 
        .sel(sel),
        .enable(btnC),
        .data(Aout)
    );

    // Instantiate mux_B
    mux mux_B (
        .ADD(B), 
        .SUB(B), 
        .SHL(B), 
        .SHR(B),
        .CMP(B), 
        .AND(B), 
        .OR(B), 
        .XOR(B),
        .NAND(B), 
        .NOR(B), 
        .XNOR(B), 
        .INV(B), 
        .NEG(B), 
        .STO(B), 
        .SWP(A),
        .LOAD(B), 
        .sel(sel),
        .enable(btnC),
        .data(Bout)
    );

    // Instantiate mux_Y
    mux mux_Y (
        .ADD(AaddB), 
        .SUB(AsubB), 
        .SHL(Y), 
        .SHR(Y),
        .CMP(AcmpB), 
        .AND(AandB), 
        .OR(AorB), 
        .XOR(AxorB),
        .NAND(AnandB), 
        .NOR(AnorB), 
        .XNOR(AxnorB), 
        .INV(Ainv), 
        .NEG(Aneg), 
        .STO(Y), 
        .SWP(Y),
        .LOAD(Y), 
        .sel(sel), 
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
