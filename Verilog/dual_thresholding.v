// A flexible version of the dual_thresholding module with a variable bit-width.

module dual_thresholding (
    input wire clk,
    input wire rst,
    input wire [17:0] oc_in,   
    input wire [4:0] counter_5_out, // 5-bit counter for timing
    input wire [2:0] counter_3_out, // 3-bit counter for timing
    output reg en_od
);
    reg [17:0] threshold_o = 17'd1000; // Example threshold for onset detection
    reg [17:0] threshold_od = 17'd500;  // Example threshold for onset detection
    reg [17:0] oc_prev;
    wire [17:0] oc_slope;
    reg onset_detected_already;
    assign oc_slope = oc_in - oc_prev;

    always @(posedge clk) begin
        if (rst) begin
            oc_prev <= 0;
            en_od   <= 0;
            onset_detected_already <= 1'b0;
        end else begin
            if (counter_5_out == 5'd0 && counter_3_out == 5'b001) begin
                oc_prev <= oc_in;
                onset_detected_already <= 1'b0;

            end
            
            if (!onset_detected_already) begin
                if ((oc_in > threshold_o) && (oc_slope > threshold_od)) begin
                    en_od <= 1'b1;
                    onset_detected_already <= 1'b1;
                end else begin
                    en_od <= 1'b0;
                end
            end
        end
    end

endmodule
