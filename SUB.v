module SUB (
  input [7:0]A,
  input [7:0]B,
  output [7:0]Y
);

  wire [7:0] negB;

  assign negB = (~B) + 1;

  wire [7:0] AminusB;
  wire [7:0] carry;
  wire[7:0] second_carry;

    // First addition
    full_adder bit0_first(
      .A(A[0]),
      .B(negB[0]),
      .Y(AminusB[0]),
        .Cin(1'b0), // Fix to zero
      .Cout(carry[0])
    );
    
    full_adder bit1_first(
      .A(A[1]),
      .B(negB[1]),
      .Y(AminusB[1]),
      .Cin(carry[0]),
      .Cout(carry[1])
    );
    
    full_adder bit2_first(
      .A(A[2]),
      .B(negB[2]),
      .Y(AminusB[2]),
      .Cin(carry[1]),
      .Cout(carry[2])
    );
    
    full_adder bit3_first(
      .A(A[3]),
      .B(negB[3]),
      .Y(AminusB[3]),
      .Cin(carry[2]),
      .Cout(carry[3])
    );

  full_adder bit4_first(
    .A(A[4]),
    .B(negB[4]),
    .Y(AminusB[4]),
    .Cin(carry[3]),
    .Cout(carry[4])
  );

  full_adder bit5_first(
    .A(A[5]),
    .B(negB[5]),
    .Y(AminusB[5]),
    .Cin(carry[4]),
    .Cout(carry[5])
  );

  full_adder bit6_first(
    .A(A[6]),
    .B(negB[6]),
    .Y(AminusB[6]),
    .Cin(carry[5]),
    .Cout(carry[6])
  );

  full_adder bit7_first(
    .A(A[7]),
    .B(negB[7]),
    .Y(AminusB[7]),
    .Cin(carry[6]),
    .Cout(carry[7])
  );

    // Second addition
    full_adder bit0_second(
      .A(AminusB[0]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[0]), // This is now the real summation
      .Cin(carry[7]), // Fix to zero
      .Cout(second_carry[0]) // We still need to carry to second
        // bit of second addition
    );
    
    full_adder bit1_second(
      .A(AminusB[1]),
        .B(1'b0),
        .Y(Y[1]),
      .Cin(second_carry[0]),
      .Cout(second_carry[1])
    );

    full_adder bit2_second(
      .A(AminusB[2]),
      .B(1'b0),
      .Y(Y[2]),
    .Cin(second_carry[1]),
    .Cout(second_carry[2])
    );
    
    full_adder bit3_second(
      .A(AminusB[3]),
      .B(1'b0),
      .Y(Y[3]),
    .Cin(second_carry[2])
    .Cout(second_carry[3])
    );

  full_adder bit4_second(
    .A(AminusB[4]),
    .B(1'b0),
    .Y(Y[4]),
    .Cin(second_carry[3]),
    .Cout(second_carry[4])
  );

  full_adder bit5_second(
    .A(AminusB[5]),
    .B(1'b0),
    .Y(Y[5]),
    .Cin(second_carry[4]),
    .Cout(second_carry[5])
  );

  full_adder bit6_second(
    .A(AminusB[6]),
    .B(1'b0),
    .Y(Y[6]),
    .Cin(second_carry[5]),
    .Cout(second_carry[6])
  );

  full_adder bit7_second(
    .A(AminusB[7]),
    .B(1'b0),
    .Y(Y[7]),
    .Cin(second_carry[6])
    // no Cout
  );
  
endmodule
