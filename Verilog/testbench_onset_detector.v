`timescale 1ns / 1ps


module onset_detector_tb;

    // Inputs
    reg clk;
    reg rst, clk_rst;
    reg clk_8MHz;

    wire [9:0] channel_r1;
    wire [9:0] channel_r2;
    wire [9:0] channel_r3;
    wire [9:0] channel_r4;
    wire [9:0] channel_r5;
    wire [9:0] channel_r6;
    // Test memory: 202 entries each 192 bits wide (matches num_channels)
    reg [192*4-1:0] test_data [0:200];
    // Signals used by instantiated mac_shift_1mult modules
    reg [3:0] module1_input, module2_input, module3_input, module4_input, module5_input, module6_input;
    wire in_ready_1, in_ready_2, in_ready_3, in_ready_4, in_ready_5, in_ready_6; 
    // Outputs
    wire [2:0] onset_detected;
    parameter real clk_period = 62.5; // 16MHz clock period in ns
    parameter num_channels = 192;

    // Add these declarations at the top of your module
    reg [3:0] module1_input_array [0:201*32-1];
    reg [3:0] module2_input_array [0:201*32-1];
    reg [3:0] module3_input_array [0:201*32-1];
    reg [3:0] module4_input_array [0:201*32-1];
    reg [3:0] module5_input_array [0:201*32-1];
    reg [3:0] module6_input_array [0:201*32-1];

    integer i,j,r,c; // Variable for the loop

    wire [4:0] one, two, three, four;
    // Instantiate the Unit Under Test (UUT)
    onset_detector od (
        .clk(clk),
        .rst(rst),
        .clk_rst(clk_rst),
        .channel_r1(channel_r1),
        .channel_r2(channel_r2),
        .channel_r3(channel_r3),
        .channel_r4(channel_r4),
        .channel_r5(channel_r5),
        .channel_r6(channel_r6),
        .onset_detected(onset_detected)
    );
/* */
    mac_shift_1mult module1   (
        .Xut(module1_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r1),
        .in_ready(in_ready_1)
    );
    mac_shift_1mult module2   (
        .Xut(module2_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r2),
        .in_ready(in_ready_2)
    );
    mac_shift_1mult module3   (
        .Xut(module3_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r3),
        .in_ready(in_ready_3)
    );
    mac_shift_1mult module4   (
        .Xut(module4_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r4),
        .in_ready(in_ready_4)
    );
    mac_shift_1mult module5   (
        .Xut(module5_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r5),
        .in_ready(in_ready_5)
    );
    mac_shift_1mult module6   (
        .Xut(module6_input), // Example connection
        .clk(clk_8MHz),
        .reset(rst),
        .Sut(channel_r6),
        .in_ready(in_ready_6)
    );

    // --- Reset and File Setup ---tr
    // 

    initial begin
        // Initialize Inputs
        clk = 1'b0;
        clk_8MHz = 1'b0;
        rst = 1'b1;
        clk_rst = 1'b1;
        j = 0;
      
        // Assert reset for 5 clock cycles
        #(clk_period * 10);
        rst = 1'b0; // De-assert reset
        #(clk_period * 10);
        clk_rst = 1'b0;
    end

    //     rst = 1;
    
    // #(125); // Wait for two 8MHz clock cycles
    // rst = 0;
     
         // Open log file
        // fd = $fopen("io_1mult_log.csv", "w");
    // $fwrite(fd, "time,in,out\n");
    initial begin   
        // Setup VCD dump
        $dumpfile("xxdump_1mult.vcd");
        $dumpvars(0, onset_detector_tb); 
        $dumpvars(0, module1);
        $dumpvars(0, module2);
        $dumpvars(0, module3);
        $dumpvars(0, module4);
        $dumpvars(0, module5);
        $dumpvars(0, module6);

    end


     // --- Load Test Data ---
    initial begin
        // 1. Initialize
        for (r = 0; r < 201; r = r + 1) test_data[r] = 768'd0;
        
        // 2. Load
        $readmemh("module1.mem", module1_input_array); // Reusing module1_input_array for full data load
        $readmemh("module2.mem", module2_input_array); // Reusing module2_input_array for full data load
        $readmemh("module3.mem", module3_input_array); // Reusing module3_input_array for full data load
        $readmemh("module4.mem", module4_input_array); // Reusing module4_input_array for full data load
        $readmemh("module5.mem", module5_input_array); // Reusing module5_input_array for full data load
        $readmemh("module6.mem", module6_input_array); // Reusing module6_input_array for full data load

        $display("Memory Loaded. Width: 768 bits.");
        
        // Debug
        #1;
        $display("Split Complete.");
        // for (r= 0; r<14; r=r+1) begin
        //     $display("Row %0d, Item 0 (Mod1): %h\n", r, module1_input_array[32*r]);
        // end
        // $display("Row 0, Item 0 (Mod1): %h", module1_input_array[224]);
        // $display("Row 0, Item 31 (Mod1): %h", module1_input_array[256]);
        // $display("Row 1, Item 0 (Mod1): %h", module1_input_array[288]); // Index 288 is the start of next row
    end
// temp
    always@(posedge rst) begin
        for (r= 0; r<14; r=r+1) begin
            $display("%0d %h %h %h %h %h\n  ", r, module1_input_array[32*r], module1_input_array[32*r + 1], module1_input_array[32*r + 2], module1_input_array[32*r + 3], module1_input_array[32*r + 4]);
        end
    end


  // --- Clock Generator ---
    always begin
        clk = 1'b0; 
        #(clk_period/2);
        clk = 1'b1; 
        #(clk_period/2);
    end

    always@(posedge clk) begin
        clk_8MHz <= ~clk_8MHz;
    end

    assign one = j % 32;
    assign two = j % 32 -1;
    assign three = j % 32 -2;
    assign four = j % 32 -3;

  // --- CORRECT DRIVING LOGIC ---
    always @(posedge clk_8MHz) begin
        if (rst) begin
            j <= 0;
            module1_input <= 0;
            module2_input <= 0;
            module3_input <= 0;
            module4_input <= 0;
            module5_input <= 0;
            module6_input <= 0;
        end
        // Only feed data if the module is ready AND we have data left (j <= 201*32-1)

        else if (in_ready_1 && (j <= 1024)) begin
            module1_input <= module1_input_array[j];
            module2_input <= module2_input_array[j];
            module3_input <= module3_input_array[j];
            module4_input <= module4_input_array[j];
            module5_input <= module5_input_array[j];
            module6_input <= module6_input_array[j];
            
            j <= j + 1; // j simply counts up continuously
            if(j%64 == 0) begin
                $display("At time %t, fed data index %0d", $time, j);
            end
        end

        else if (j > 1024) begin
            // Optional: Stop simulation or hold last value when data runs out
             $display("Test data finished at time %t", $time);
             rst <= 1'b1;
             $finish; 
        end
    end
endmodule
