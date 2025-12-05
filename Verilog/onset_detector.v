module onset_detector (
    input wire clk,//16MHz
    input wire rst,
    input wire clk_rst,
    input wire [9:0] channel_r1,
    input wire [9:0] channel_r2,
    input wire [9:0] channel_r3,
    input wire [9:0] channel_r4,
    input wire [9:0] channel_r5,
    input wire [9:0] channel_r6,
    output wire [30:0] onset_detected
);
    // Make a clk divider to make these clocks
    wire clk_4096k;
    wire clk_512k;

    wire [7:0] channel;
    
    wire [4:0] counter_32_out;
    wire [2:0] counter_8_out;

    wire [9:0] mult_a;

    wire [7:0] class1_weight;
    wire [7:0] class2_weight; //write for all classes

    wire [17:0] class1_add_in;
    wire [17:0] class2_add_in;

    wire [17:0] class1_activity_in;
    wire [17:0] class2_activity_in;

    wire [17:0] class1_activity;
    wire [17:0] class2_activity;
    wire [17:0] class3_activity, class4_activity, class5_activity, class6_activity, class7_activity, class8_activity,
           class9_activity, class10_activity, class11_activity, class12_activity, class13_activity,
           class14_activity, class15_activity, class16_activity, class17_activity, class18_activity,
           class19_activity, class20_activity, class21_activity, class22_activity, class23_activity,
           class24_activity, class25_activity, class26_activity, class27_activity, class28_activity,
           class29_activity, class30_activity, class31_activity;
    wire class_activity_rst;
    wire [4:0] clk_divider_out ;

    integer i;

    reg[17:0] class_activity[0:30];
    wire[17:0] class_activity_next[0:30];

    assign class_activity_rst = (counter_32_out == 5'b00000) ? 1'b1 : 1'b0;
    // assign clk_4096k = counter_8_out[0]
    // Assign outputs to specific bits of the counter
    counter_gen u_counter_gen(
        .clk(clk), // Master Clock: 16384 kHz
        .rst(rst),
        .counter_5_out(counter_32_out),//512kH
        .counter_3_out(counter_8_out),
        .clk_4096k(clk_4096k)
    );

    mux8X1 u_mux8X1 (
        .inp0(channel_r1),
        .inp1(channel_r2),
        .inp2(channel_r3),
        .inp3(channel_r4),
        .inp4(channel_r5),
        .inp5(channel_r6),
        .inp6(10'b0),
        .inp7(10'b0), 
        .sel(counter_8_out), // Connect selection signal as needed
        .out(mult_a)  // Connect output as needed
    );

    channel_cal u_channel_cal (
        .counter_32_out(counter_32_out),
        .counter_8_out(counter_8_out),
        .channel(channel)
    );

    class1_top_channels u_class1_top_channels(
        .clk(clk_4096k),
        .rst(clk_rst),
        .channel(channel),
        .channel_weight(class1_weight)
    );

    class2_top_channels u_class2_top_channels(
        .clk(clk_4096k),
        .rst(clk_rst),
        .channel(channel),
        .channel_weight(class2_weight)
    );

    mult10X8 u1_mult10X8 (
        .a(mult_a),  
        .b(class1_weight),
        .product(class1_add_in) 
    );

    mult10X8 u2_mult10X8 (
        .a(mult_a),  
        .b(class2_weight),
        .product(class2_add_in) 
    );

    adder_18bit u1_adder_16bit (
        .a(class_activity[0]),  
        .b(class1_add_in),
        .sum(class_activity_next[0]) 
    );

    adder_18bit u2_adder_16bit (
        .a(class_activity[1]),  
        .b(class2_add_in),
        .sum(class_activity_next[1]) 
    );

    dual_thresholding u_dual_threshold_class1 (
        .clk(clk_4096k),
        .rst(clk_rst),
        .oc_in(class_activity[0]),  // Connects our 16-bit wire to the submodule input
        .counter_5_out(counter_32_out),
        .counter_3_out(counter_8_out),
        .en_od(onset_detected[0])    // Connects submodule output directly to parent output
    );

    dual_thresholding u_dual_threshold_class2 (
        .clk(clk_4096k),
        .rst(clk_rst),
        .oc_in(class_activity[1]),  // Connects our 16-bit wire to the submodule input
        .counter_5_out(counter_32_out),
        .counter_3_out(counter_8_out),
        .en_od(onset_detected[1])    // Connects submodule output directly to parent output
    );

    // 1. Create a register to remember the previous state of your slow clock/counter bit
reg prev_clk_4096k;
wire enable_strobe;

// 2. Track the previous state on every Master Clock cycle
always @(posedge clk) begin
    if (rst) 
        prev_clk_4096k <= 0;
    else 
        prev_clk_4096k <= clk_4096k; // Store the "old" value
end

// 3. Generate the strobe: High ONLY when current is 1 and old was 0 (Rising Edge)
assign enable_strobe = (clk_4096k == 1'b1 && prev_clk_4096k == 1'b0);

    always@(posedge clk) begin
        if (class_activity_rst) begin
            // Reset logic if needed
           for (i = 0; i < 31; i = i + 1) class_activity[i] <= 18'b0;
        end else if (enable_strobe)begin
           for (i = 0; i < 31; i = i + 1) class_activity[i] <= class_activity_next[i];


            // adder logic for class1_activity_in
            // class1_activity_in <= class1_activity + class1_add_in;
            // adder logic for class2_activity_in
            // class2_activity_in <= class2_activity + class2_add_in;
        end
    end

    assign class1_activity = class_activity[0];
    assign class2_activity = class_activity[1]; 
    assign class1_activity_in = class_activity_next[0];
    assign class2_activity_in = class_activity_next[1];
    // assign class3_activity = class_activity[2];

    // mean_class_activity u_mean_class_activity(

    //     .clk(clk_4096k),
    //     .rst(class_activity_rst),
    //     .counter_3_out(counter_8_out),
    // // Inputs
    //     .class1_activity_in(class1_add_in),
    //     .class2_activity_in(class2_add_in),
    //     .class3_activity_in(18'b0),
    //     .class4_activity_in(18'b0),
    //     .class5_activity_in(18'b0),
    //     .class6_activity_in(18'b0),
    //     .class7_activity_in(18'b0),
    //     .class8_activity_in(18'b0),
    //     .class9_activity_in(18'b0),
    //     .class10_activity_in(18'b0),
    //     .class11_activity_in(18'b0),
    //     .class12_activity_in(18'b0),
    //     .class13_activity_in(18'b0),
    //     .class14_activity_in(18'b0),
    //     .class15_activity_in(18'b0),
    //     .class16_activity_in(18'b0),
    //     .class17_activity_in(18'b0),
    //     .class18_activity_in(18'b0),
    //     .class19_activity_in(18'b0),
    //     .class20_activity_in(18'b0),
    //     .class21_activity_in(18'b0),
    //     .class22_activity_in(18'b0),
    //     .class23_activity_in(18'b0),
    //     .class24_activity_in(18'b0),
    //     .class25_activity_in(18'b0),
    //     .class26_activity_in(18'b0),
    //     .class27_activity_in(18'b0),
    //     .class28_activity_in(18'b0),
    //     .class29_activity_in(18'b0),
    //     .class30_activity_in(18'b0),
    //     .class31_activity_in(18'b0),
    // // Outputs
    //     .class1_activity(class1_activity),
    //     .class2_activity(class2_activity),
    //     .class3_activity(class3_activity),
    //     .class4_activity(class4_activity),
    //     .class5_activity(class5_activity),
    //     .class6_activity(class6_activity),
    //     .class7_activity(class7_activity),
    //     .class8_activity(class8_activity),
    //     .class9_activity(class9_activity),
    //     .class10_activity(class10_activity),
    //     .class11_activity(class11_activity),
    //     .class12_activity(class12_activity),
    //     .class13_activity(class13_activity),
    //     .class14_activity(class14_activity),
    //     .class15_activity(class15_activity),
    //     .class16_activity(class16_activity),
    //     .class17_activity(class17_activity),
    //     .class18_activity(class18_activity),
    //     .class19_activity(class19_activity),
    //     .class20_activity(class20_activity),
    //     .class21_activity(class21_activity),
    //     .class22_activity(class22_activity),
    //     .class23_activity(class23_activity),
    //     .class24_activity(class24_activity),
    //     .class25_activity(class25_activity),
    //     .class26_activity(class26_activity),
    //     .class27_activity(class27_activity),
    //     .class28_activity(class28_activity),
    //     .class29_activity(class29_activity),
    //     .class30_activity(class30_activity),
    //     .class31_activity(class31_activity)
    // );
endmodule