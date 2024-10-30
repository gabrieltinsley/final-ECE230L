module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] anode
);

    // This block should count through from zero to three, and only activate one
    // anode at a time in the seven segment displays. Keep in mind THEY ARE
    // INVERSE DRIVE, that is that 0 is on 1 is off

    // The reset line should set things back to segment 0

    // Anodes are:
    // 0: R
    // 1: RC
    // 2: LC
    // 3: L

    reg [1:0] count;  // 2-bit counter to cycle through anodes

    // Counter logic that cycles from 0 to 3
    always @(posedge div_clock or posedge reset) begin
        if (reset) 
            count <= 2'b00;  // Reset the counter to 0
        else 
            count <= count + 1'b1;  // Increment the counter
    end

    // Anode selection logic (inverse drive, 0 is on, 1 is off)
    always @(*) begin
        case (count)
            2'b00: anode = 4'b1110;  // Anode 0 (R) is active
            2'b01: anode = 4'b1101;  // Anode 1 (RC) is active
            2'b10: anode = 4'b1011;  // Anode 2 (LC) is active
            2'b11: anode = 4'b0111;  // Anode 3 (L) is active
        endcase
    end

endmodule
