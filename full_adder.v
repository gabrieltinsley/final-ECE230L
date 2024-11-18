module full_adder(
    input A, B, Cin,
    output Y, Cout
);
    wire sum;

    assign sum = A ^ B;
    assign Y = sum ^ Cin;

    assign Cout = (A & B) | (Cin & sum);

endmodule
