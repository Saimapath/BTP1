module mult10X8(
    input wire [9:0] a,
    input wire [7:0] b,
    output wire [17:0] product
);
    assign product = a * b;

endmodule