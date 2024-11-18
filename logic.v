module and_logic(
  input andA, andB,
  output andY
);

  assign andY = andA & andB;

endmodule

module or_logic(
  input orA, orB,
  output orY
);

  assign orY = orA | orB;

endmodule

module logic
#(
    parameter BITS = 16
)
(
  input A, B,
  output Y,
);
  genvar i;
  reg [16:0] bits_out;

  // each iteration through the for loop instiates and AND's the number A and B together 

  // possibly make a decoder to choose when to do AND / OR logic
  
  generate
    for(i = 0; i < BITS; i = i + 1) begin 
      and_logic port5(.andY(bits_out[i-1]));

      or_logic port6(.orY(bits_out[i-1]));
    end
  endgenerate
endmodule
  
