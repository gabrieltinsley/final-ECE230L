module math_block(
    input [3:0] A,
    input [3:0] B,
    output reg [3:0] AplusB,
    output reg [3:0] AminusB
);

    // This one should be relatively easy.  You can either use your previous
    // four bit adders and two's compliment converters that you implemented in
    // previous labs, or set up some behavioral verilog to do the job for you

     // Always block to handle addition and subtraction
    always @(*) begin
        AplusB = A + B;      
        AminusB = A - B;     
    end

   // Use full_adder just like week 6 lab for addition and subtraction

    // Shift left is x2
    // Shift right is /2
    
    
        

endmodule
