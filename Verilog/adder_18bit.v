module adder_18bit(
    input wire [17:0] a,
    input wire [17:0] b,
    output wire [17:0] sum
);
    assign sum = a + b;
endmodule