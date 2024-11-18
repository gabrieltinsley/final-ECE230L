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
    wire lowerY;
    wire upperY;
    
   


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
