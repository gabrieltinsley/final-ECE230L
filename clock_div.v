module dff(
    input reset,
    input clock,
    input D,
    output reg Q
);

    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else if (clock) begin
            Q <= ~Q;
        end
    end
endmodule

module clock_div
#(
    parameter DIVIDE_BY = 17 // Or 100,000 for counter implementation
)
(
    input clock,
    input reset,
    output reg div_clock
);

    wire [DIVIDE_BY:0] qOut;

    dff firstDff(
        .reset(reset),
        .clock(clock),
        .Q(qOut[0])
    );

    genvar i;

    generate
        for (i = 1; i <= DIVIDE_BY; i = i + 1) begin
            dff dff_inst(
                .reset(reset),
                .clock(qOut[i - 1]),
                .Q(qOut[i])
            );

        end
    endgenerate
    
    always @(*) begin
        div_clock = qOut[DIVIDE_BY];
    end

endmodule
