module seven_seg_decoder(
    input [3:0] Val,
    input [3:0] lowerY,
    input [3:0] upperY,
    input [3:0] anode,
    output reg [6:0] segs
);

    // This module should be purely combinatorial -- no reset required. What we
    // are going to do here is simply display the correct four bit number
    // according to the table provided in the lab deliverables section

    reg [3:0] selected_sig;

    // Recommended you do a simple behavioral implementation:
    always @(*) begin
      case (anode)
         'b1110: selected_sig <= Val; // Right
         'b1101: selected_sig <= 0; // Right Center
         'b1011: selected_sig <= lowerY; // Left Center
         'b0111: selected_sig <= upperY; // Left
      endcase

    // You will also need a very simple decoder that assigns the segs components
    // based on the 4 bit input number to hexidecimal digit

    // For reference:
    always @(*) begin
        case(selected_sig)
            //                 GFEDCBA
            4'b0000: segs = 7'b1000000;  // 0
            4'b0001: segs = 7'b1111001;  // 1
            4'b0010: segs = 7'b0100100;  // 2
            4'b0011: segs = 7'b0110000;  // 3
            4'b0100: segs = 7'b0011001;  // 4
            4'b0101: segs = 7'b0010010;  // 5
            4'b0110: segs = 7'b0000010;  // 6
            4'b0111: segs = 7'b1111000;  // 7
            4'b1000: segs = 7'b0000000;  // 8
            4'b1001: segs = 7'b0010000;  // 9
            4'b1010: segs = 7'b0001000;  // A
            4'b1011: segs = 7'b0000011;  // B
            4'b1100: segs = 7'b1000110;  // C
            4'b1101: segs = 7'b0100001;  // D
            4'b1110: segs = 7'b0000110;  // E
            4'b1111: segs = 7'b0001110;  // F       
        endcase
    end

endmodule
