module mux8X1 (
    input wire [9:0] inp0,
    input wire [9:0] inp1,
    input wire [9:0] inp2,
    input wire [9:0] inp3,
    input wire [9:0] inp4,
    input wire [9:0] inp5,
    input wire [9:0] inp6,
    input wire [9:0] inp7,

    input wire [2:0] sel,
    output reg [9:0] out
);

always @(*) begin
    case (sel)
        3'b000: out = inp0;
        3'b001: out = inp1;
        3'b010: out = inp2;
        3'b011: out = inp3;
        3'b100: out = inp4;
        3'b101: out = inp5;
        3'b110: out = inp6;
        3'b111: out = inp7;
    endcase
end

endmodule
