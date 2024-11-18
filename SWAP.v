module SWAP(
  inout [7:0] A,
  inout [7:0] B
);

  assign A => B;
  assign B => A;

endmodule

  
