module top
#(
    parameter BIT_COUNT = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [15:0] sw, // A 
    input btnC, // clock
    input btnU, // reset
    input clk,
    output [3:0] an, // 7seg anodes
    output [6:0] seg, // 7seg segments
    output [15:0] led
);

    reg [7:0] A;
    reg [7:0] B;
    reg [7:0] Y;
    // Instantiate the clock divider...
    // ... wire it up to the scanner
    // ... wire the scanner to the decoder

    // Wire up the math block into the decoder

    // Do not forget to wire up resets!!
    // Clock divider output
    wire div_clock;
    
    // Instantiate the clock divider
    clock_div #(.DIVIDE_BY(BIT_COUNT)) clk_div_inst (
        .clock(clk),
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
        .Y(Ainv)
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
    wire [7:0] BswpA;

    SWP op14 (
        .clock(btnC),
        .swap(btnC),
        .A(AswpB),
        .B(BswpA)
    );
    
    wire [7:0] Aload;

    LOAD op15 (
        .A(Aload),
        .clock(btnC),
        .load(btnC),
        .switches(sw[15:8])
    );

    // Split switches into two 4-bit signals lowerY and upperY
    wire [3:0] lowerY;
    wire [3:0] upperY;

   

    // Intermediate wires
    wire [7:0] Aout;
    wire [7:0] Bout;
    wire [7:0] Yout;
    
    assign led[15:8] = A;
    assign led[7:0] = B;
    assign {upperY, lowerY} = Y;

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
        .SWP(AswpB),
        .LOAD(A), 
        .sel(sw[3:0]),
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
        .SWP(BswpA),
        .LOAD(B), 
        .sel(sw[3:0]),
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
        .sel(sw[3:0]), 
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
