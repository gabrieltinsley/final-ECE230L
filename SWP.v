module SWP(
  input clock,             // Clock signal to control swapping
  input swap,            // Control signal to trigger the swap
  output reg [7:0] A,         // 8-bit register A
  output reg [7:0] B          // 8-bit register B
);

  reg [7:0] temp;
  
  always @(posedge clock) begin
    if (swap) begin
      // Use a temporary variable to swap A and B
      temp <= A;
      A <= B;
      B <= temp;
    end
  end
endmodule

  
