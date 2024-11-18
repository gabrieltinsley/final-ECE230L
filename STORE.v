module STORE(
    input [7:0] A,
    input store,
    output reg [7:0] Y
);

    // Herein, implement D-Latch style memory
    // that stores the input data into memory
    // when store is high
  always @(store) begin
    if(store)
      Y <= A;
    else if(~store)
      Y <= Y;
  end

    // Memory should always output the value
    // stored, and it should only change
    // when store is high

endmodule
