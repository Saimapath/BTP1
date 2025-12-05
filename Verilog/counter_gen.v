module counter_gen (
    input wire clk,      // 16384kHz (Main System Clock)
    input wire rst,
    output wire [2:0] counter_3_out,
    output wire [4:0] counter_5_out,
    output wire clk_4096k
);
    // 1. Fix the reg/wire syntax error
    wire [4:0] clk_maker_out; 
    
    // 2. Generate Enables instead of Clocks
    // Pulse 'en_4096' every 4th cycle (when lower 2 bits roll over)
    wire en_4096;
    assign en_4096 = (clk_maker_out[1:0] == 2'b11); 

    // Pulse 'en_512' every 32nd cycle (when all 5 bits roll over)
    wire en_512;
    assign en_512 = (clk_maker_out[4:0] == 5'b11111);

    // Output assignments for observation
    assign clk_4096k = !clk_maker_out[1];    

    // 3. Connect Main Clock to EVERY module
    counter_3bit_gate_level u_counter_3bit (
        .clk(clk),        // USE MAIN CLOCK
        .en(en_4096),     // CONNECT ENABLE
        .rst(rst),
        .q(counter_3_out)
    );

     counter_5bit_gate u1_counter_5bit (
        .clk(clk),        // USE MAIN CLOCK
        .en(en_512),      // CONNECT ENABLE
        .rst(rst),
        .q(counter_5_out)
    );
    
    // The Master Counter (runs every cycle, so en is tied to 1)
    counter_5bit_gate u_counter_5bit (
        .clk(clk),
        .en(1'b1),        // ALWAYS ENABLED
        .rst(rst),
        .q(clk_maker_out)
    );

endmodule

// Updated 3-bit counter with Enable and Sync Reset
module counter_3bit_gate_level (
    input wire clk,
    input wire en,    // Added Enable input
    input wire rst,
    output reg [2:0] q
);

    always @(posedge clk) begin  // Synchronous Reset (No "or posedge rst")
        if (rst) begin
            q <= 3'b000;
        end else if (en) begin   // Only update if Enable is High
            q[0] <= ~q[0];
            q[1] <= q[1] ^ q[0];
            q[2] <= q[2] ^ (q[1] & q[0]);
        end
    end

endmodule

// Updated 5-bit counter with Enable and Sync Reset
module counter_5bit_gate (
    input wire clk,
    input wire en,    // Added Enable input
    input wire rst,
    output reg [4:0] q
);

    always @(posedge clk) begin  // Synchronous Reset
        if (rst) begin
            q <= 5'b11101;
        end else if (en) begin   // Only update if Enable is High
            q[0] <= ~q[0];
            q[1] <= q[1] ^ q[0];
            q[2] <= q[2] ^ (q[1] & q[0]);
            q[3] <= q[3] ^ (q[2] & q[1] & q[0]);
            q[4] <= q[4] ^ (q[3] & q[2] & q[1] & q[0]);
        end
    end

endmodule