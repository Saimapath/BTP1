module channel_cal (
    input  wire [4:0] counter_32_out,
    input  wire [2:0] counter_8_out,
    output reg  [7:0] channel
);

always @(*) begin
    case (counter_8_out)
        3'b000: channel = counter_32_out;
        3'b001: channel = counter_32_out + 8'd32;
        3'b010: channel = counter_32_out + 8'd64;
        3'b011: channel = counter_32_out + 8'd96;
        3'b100: channel = counter_32_out + 8'd128;
        3'b101: channel = counter_32_out + 8'd160;
        3'b110: channel = counter_32_out + 8'd192;
        3'b111: channel = counter_32_out + 8'd224;
    endcase
end

endmodule
