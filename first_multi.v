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
  
