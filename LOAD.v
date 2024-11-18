module LOAD (
    input [7:0] switches,   // 8-bit input from switches or external source
    input load,             // Load signal (active high)
    input clock,              // Clock signal
    output reg [7:0] A          // 8-bit register A
);
    // Load operation
  always @(posedge clock) begin
        if (load) begin
            A <= switches;      // Load the value from switches into A when load is high
        end
    end
endmodule
