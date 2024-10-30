// This is the multiplexer that takes 16 inputs 

module first_multi(
  input [7:0] zero,
  input [7:0] one,
  input [7:0] two,
  input [7:0] three,
  input [7:0] four,
  input [7:0] five,
  input [7:0] six,
  input [7:0] seven,
  input [7:0] eight,
  input [7:0] nine,
  input [7:0] A_ten,
  input [7:0] B_eleven,
  input [7:0] C_twelve,
  input [7:0] D_thirteen,
  input [7:0] E_fourteen,
  input [7:0] F_fifteen,
  input [3:0] sel,
  input enable,
  output reg [7:0] data
);

  always @(*) begin
    if (enable) begin
      case (sel)
        4'b0000: data = zero;
        4'b0001: data = one;
        4'b0010: data = two;
        4'b0011: data = three;
        4'b0100: data = four;
        4'b0101: data = five;
        4'b0110: data = six;
        4'b0111: data = seven;
        4'b1000: data = eight;
        4'b1001: data = nine;
        4'b1010: data = A_ten;
        4'b1011: data = B_eleven;
        4'b1100: data = C_twelve;
        4'b1101: data = D_thirteen;
        4'b1110: data = E_fourteen;
        4'b1111: data = F_fifteen;
        end else begin
          data = 0;
        end 
      end
endmodule
  
