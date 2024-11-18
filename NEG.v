module NEG (
  input [7:0] A,
  output [7:0] Y
);

  wire [7:0] negA;

  assign negA = ~A;

  wire [7:0] carry1;

  full_adder bit0(
    .A(negA[0]),
    .B(1'b0),
    .Cin(1'b1),
    .Y(Y[0]),
    .Cout(carry1[0])
  );

  full_adder bit1(
    .A(negA[1]),
    .B(1'b0),
    .Cin(carry1[0]),
    .Y(Y[1]),
    .Cout(carry1[1])
  );

  full_adder bit2(
    .A(negA[2]),
    .B(1'b0),
    .Cin(carry1[1]),
    .Y(Y[2]),
    .Cout(carry1[2])
  );

    full_adder bit3(
      .A(negA[3]),
      .B(1'b0),
      .Cin(carry1[2]),
      .Y(Y[3]),
      .Cout(carry1[3])
  );

  full_adder bit4(
     .A(negA[4]),
     .B(1'b0),
     .Cin(carry1[3]),
     .Y(Y[4]),
     .Cout(carry1[4])
  );

    full_adder bit5(
      .A(negA[5]),
      .B(1'b0),
      .Cin(carry1[4]),
      .Y(Y[5]),
      .Cout(carry1[5])
  );

  full_adder bit6(
    .A(negA[6]),
    .B(1'b0),
    .Cin(carry1[5]),
    .Y(Y[6]),
    .Cout(carry1[6])
  );

    full_adder bit7(
      .A(negA[7]),
      .B(1'b0),
      .Cin(carry1[6]),
      .Y(Y[7])
  );
endmodule
  
