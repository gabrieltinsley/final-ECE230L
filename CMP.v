module CMP(
  input [7:0] A,
  input [7:0] B,
  output reg signed [7:0] Y
);

  always @(A, B) begin
    if(A == B)
      Y <= 0;
    else if(A > B)
      Y <= 1;
    else 
      Y <= -1;
  end
endmodule
