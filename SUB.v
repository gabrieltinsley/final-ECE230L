module SUB (
  input [7:0]A,
  input [7:0]B,
  output [7:0]Y
);

  wire [7:0] negB;

  assign negB = ~B;

  wire [3:0] AminusB;
  wire [3:0]carry;


  wire[3:0] second_carry;
  wire around;

    // First addition
    full_adder lsb_inter_first(
      .A(A[0]),
      .B(B[0]),
        .Y(APlusB[0]),
        .Cin(1'b0), // Fix to zero
      .Cout(carry[0])
    );
    
    full_adder msb_inter_second(
      .A(A[1]),
      .B(B[1]),
        .Y(APlusB[1]),
      .Cin(carry[0]),
      .Cout(carry[1])
    );
    
    full_adder msb_inter_third(
      .A(A[2]),
      .B(B[2]),
      .Y(APlusB[2]),
      .Cin(carry[1]),
      .Cout(carry[2])
    );
    
    full_adder msb_inter_fourth(
      .A(A[3]),
      .B(B[3]),
      .Y(APlusB[3]),
      .Cin(carry[2]),
      .Cout(carry[3])
    );

    // Second addition
    full_adder lsb0(
        .A(APlusB[0]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[0]), // This is now the real summation
        .Cin(carry[3]), // Fix to zero
      .Cout(second_carry[0]) // We still need to carry to second
        // bit of second addition
    );
    
    full_adder msb1(
        .A(APlusB[1]),
        .B(1'b0),
        .Y(Y[1]),
      .Cin(second_carry[0]),
      .Cout(second_carry[1])
        // no carry out!
    );

    full_adder msb2(
      .A(APlusB[2]),
      .B(1'b0),
      .Y(Y[2]),
    .Cin(second_carry[1]),
    .Cout(second_carry[2])
        // no carry out!
    );
    
    full_adder msb3(
      .A(APlusB[3]),
      .B(1'b0),
      .Y(Y[3]),
    .Cin(second_carry[2])
    //.Cout(second_carry[3])
        // no carry out!
    );
  
endmodule
