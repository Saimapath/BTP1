module class1_top_channels(
    input clk,
    input rst,
    input [7:0] channel,
    output reg [7:0] channel_weight
);
    reg [15:0] top_channel_weights[0:31];
    integer i;
    reg found;

    always @(posedge clk) begin
        if (rst) begin
            top_channel_weights[0]  <= 16'h001D;
            top_channel_weights[1]  <= 16'h103C;
            top_channel_weights[2]  <= 16'h015B;
            // ...
            top_channel_weights[30] <= 16'hC0BF;
            top_channel_weights[31] <= 16'hDFDE;
            channel_weight <= 8'h00;
            for (i = 3; i < 30; i = i + 1) begin
                // $display("Top Channel %0d: Channel %0d with Weight %0d", i, top_channel_weights[i][15:8], top_channel_weights[i][7:0]);
                top_channel_weights[i] <= 16'h0000; // Placeholder values
            end
//            found <= 1'b0;
        end else begin
            //channel_weight <= 8'h00; // default
            found = 1'b0;
            for (i = 0; i < 32; i = i + 1) begin
                // $display("Checking channel %0d against top channel %0d with weight %0d at time %t", channel, top_channel_weights[i][15:8], top_channel_weights[i][7:0], $time);
                if (!found && (channel == top_channel_weights[i][15:8])) begin
                    channel_weight <= top_channel_weights[i][7:0];
                    found = 1'b1; // emulate break

                    // $display("Channel %h matched with weight %h at time %t", channel, channel_weight, $time); 
                    
                end
            end
        end
    end
endmodule
