module mac_shift_1mult #(
    parameter input_width = 4,
    parameter output_width = 10,
    parameter coeff_width = 4,
    parameter kernel_width  = 16,
    parameter num_channels = 32
) (
    input [input_width-1:0] Xut,
    input clk, reset,
    output reg[output_width-1:0] Sut,
    output in_ready
);

    // --- Internal Wires and Regs ---
    wire [3:0] tap_num;      // Output from the 4-bit tap counter
    wire [4:0] channel_num;  // Output from the 5-bit channel counter
    
    // This 'enable' signal tells the channel counter to increment
    wire channel_en = (tap_num == 15); 
    
    reg [input_width-1:0] x_reg;      // Latches the input for 16 cycles
    reg [coeff_width-1:0] coeff_out;  // Output of the synthesizable ROM
    
    // This infers a 32-word memory (BRAM) for the partial sums
    reg [output_width-1:0] partial_sum_reg[num_channels*kernel_width-1:0];
    integer k;

    // --- Single Multiplier and Adder Wires ---
    wire [output_width-1:0] mult_out;
    wire [output_width-1:0] addin;
    reg [output_width-1:0] addin_next;
    wire [output_width-1:0] add_out;


    assign addin = (tap_num == 0) ? 0 : addin_next;

    // --- Instantiate Counters ---
    counter_4bit tap_counter (
        .clk(clk),
        .reset(reset),
        .count(tap_num)
    );
    
    counter_5bit_en channel_counter (
        .clk(clk),
        .reset(reset),
        .enable(channel_en), // Only increments when tap_num == 15
        .count(channel_num)
    );

    // --- Instantiate Single Multiplier and Adder ---
    mult m1 (
        .a(x_reg), 
        .b(coeff_out),
        .c(mult_out)
    );

    // The input to the adder is the partial sum from the previous tap.
    // When tap_num is 0, we force '0' to start the sum.

    add a1 (
        .a(mult_out), 
        .b(addin), 
        .c(add_out)
    );

    // --- Synthesizable Coefficient ROM ---
    // This creates a combinatorial ROM from LUTs.
    always @(*) begin
        case (tap_num)
            0:  coeff_out = 4'd0; // h[15]
            1:  coeff_out = 4'd0; // h[14]
            2:  coeff_out = 4'd1; // h[13]
            3:  coeff_out = 4'd1; // h[12]
            4:  coeff_out = 4'd1; // h[11]
            5:  coeff_out = 4'd2; // h[10]
            6:  coeff_out = 4'd2; // h[9]
            7:  coeff_out = 4'd2; // h[8]
            8:  coeff_out = 4'd2; // h[7]
            9:  coeff_out = 4'd2; // h[6]
            10: coeff_out = 4'd1; // h[5]
            11: coeff_out = 4'd1; // h[4]
            12: coeff_out = 4'd1; // h[3]
            13: coeff_out = 4'd0; // h[2]
            14: coeff_out = 4'd0; // h[1]
            15: coeff_out = 4'd0; // h[0]
            default: coeff_out = 4'd0; // Default case is required
        endcase
    end

    initial begin
    
    // for (k = 0; k < kernel_width; k = k + 1) begin
    //     coeffs[k] = 4'd1;
    // end
    for (k = 0; k < num_channels*kernel_width; k = k + 1) begin
        partial_sum_reg[k] = 0;
    end
    end

    assign in_ready = (tap_num == 15);

    // --- Main Sequential Logic ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state registers
            addin_next <= 0;
            x_reg <= 0;
             Sut <= 0;
        end else begin
            
            // Store the result of this tap's calculation back into the
            // memory for the current channel.

            addin_next <= partial_sum_reg[channel_num*kernel_width + (tap_num)];

            partial_sum_reg[channel_num*kernel_width + tap_num] <= add_out;

            // When tap_num is 15, the add_out wire holds the
            // final sum. We latch this into the Sut output register.
            // if (tap_num == 15) begin
            //     Sut <= add_out;
            // end
            
            // Latch the new Xut input only on the first tap
            if (tap_num == 15) begin
                x_reg <= Xut;
                Sut <= partial_sum_reg[channel_num*kernel_width+15];
            end
        end
    end

endmodule

// --- 4-bit Tap Counter (0-15) ---
module counter_4bit (
    input clk,
    input reset,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            count <= count + 1; // Wraps 15 -> 0 automatically
        end
    end
endmodule

// --- 5-bit Channel Counter (0-31) with Enable ---
module counter_5bit_en (
    input clk,
    input reset,
    input enable, // Only counts when this is high
    output reg [4:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else if (enable) begin // Only increments if enabled
            if (count == 31)
                count <= 0;
            else
                count <= count + 1;
        end
    end
endmodule

// --- Single Multiplier ---
module mult #(
    parameter A_WIDTH = 4,
    parameter B_WIDTH = 4,
    parameter P_WIDTH = 10
) (
    input [A_WIDTH-1:0] a,
    input [B_WIDTH-1:0] b,
    output [P_WIDTH-1:0] c
);
    assign c = a * b;
endmodule

// --- Single Adder ---
module add #(
    parameter add_width = 10,
    parameter sum_width = 10
) (
    input [add_width-1:0] a,
    input [add_width-1:0] b,
    output [sum_width-1:0] c
);
    assign c = a + b;
endmodule