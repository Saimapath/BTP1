module mean_class_activity (

    input wire clk,
    input wire rst,
    // Inputs
    input wire [17:0] class1_activity_in,
    input wire [17:0] class2_activity_in,
    input wire [17:0] class3_activity_in,
    input wire [17:0] class4_activity_in,
    input wire [17:0] class5_activity_in,
    input wire [17:0] class6_activity_in,
    input wire [17:0] class7_activity_in,
    input wire [17:0] class8_activity_in,
    input wire [17:0] class9_activity_in,
    input wire [17:0] class10_activity_in,
    input wire [17:0] class11_activity_in,
    input wire [17:0] class12_activity_in,
    input wire [17:0] class13_activity_in,
    input wire [17:0] class14_activity_in,
    input wire [17:0] class15_activity_in,
    input wire [17:0] class16_activity_in,
    input wire [17:0] class17_activity_in,
    input wire [17:0] class18_activity_in,
    input wire [17:0] class19_activity_in,
    input wire [17:0] class20_activity_in,
    input wire [17:0] class21_activity_in,
    input wire [17:0] class22_activity_in,
    input wire [17:0] class23_activity_in,
    input wire [17:0] class24_activity_in,
    input wire [17:0] class25_activity_in,
    input wire [17:0] class26_activity_in,
    input wire [17:0] class27_activity_in,
    input wire [17:0] class28_activity_in,
    input wire [17:0] class29_activity_in,
    input wire [17:0] class30_activity_in,
    input wire [17:0] class31_activity_in,

    // Outputs
    output reg [17:0] class1_activity,
    output reg [17:0] class2_activity,
    output reg [17:0] class3_activity,
    output reg [17:0] class4_activity,
    output reg [17:0] class5_activity,
    output reg [17:0] class6_activity,
    output reg [17:0] class7_activity,
    output reg [17:0] class8_activity,
    output reg [17:0] class9_activity,
    output reg [17:0] class10_activity,
    output reg [17:0] class11_activity,
    output reg [17:0] class12_activity,
    output reg [17:0] class13_activity,
    output reg [17:0] class14_activity,
    output reg [17:0] class15_activity,
    output reg [17:0] class16_activity,
    output reg [17:0] class17_activity,
    output reg [17:0] class18_activity,
    output reg [17:0] class19_activity,
    output reg [17:0] class20_activity,
    output reg [17:0] class21_activity,
    output reg [17:0] class22_activity,
    output reg [17:0] class23_activity,
    output reg [17:0] class24_activity,
    output reg [17:0] class25_activity,
    output reg [17:0] class26_activity,
    output reg [17:0] class27_activity,
    output reg [17:0] class28_activity,
    output reg [17:0] class29_activity,
    output reg [17:0] class30_activity,
    output reg [17:0] class31_activity
);
    always @(posedge clk) begin
        if (rst) begin
            class1_activity <= 18'b0;
            class2_activity <= 18'b0;
            class3_activity <= 18'b0;
            class4_activity <= 18'b0;
            class5_activity <= 18'b0;
            class6_activity <= 18'b0;
            class7_activity <= 18'b0;
            class8_activity <= 18'b0;
            class9_activity <= 18'b0;
            class10_activity <= 18'b0;
            class11_activity <= 18'b0;
            class12_activity <= 18'b0;
            class13_activity <= 18'b0;
            class14_activity <= 18'b0;
            class15_activity <= 18'b0;
            class16_activity <= 18'b0;
            class17_activity <= 18'b0;
            class18_activity <= 18'b0;
            class19_activity <= 18'b0;
            class20_activity <= 18'b0;
            class21_activity <= 18'b0;
            class22_activity <= 18'b0;
            class23_activity <= 18'b0;
            class24_activity <= 18'b0;
            class25_activity <= 18'b0;
            class26_activity <= 18'b0;
            class27_activity <= 18'b0;
            class28_activity <= 18'b0;
            class29_activity <= 18'b0;
            class30_activity <= 18'b0;
            class31_activity <= 18'b0;
        end else begin
            class1_activity <= class1_activity_in;
            class2_activity <= class2_activity_in;
            class3_activity <= class3_activity_in;
            class4_activity <= class4_activity_in;
            class5_activity <= class5_activity_in;
            class6_activity <= class6_activity_in;
            class7_activity <= class7_activity_in;
            class8_activity <= class8_activity_in;
            class9_activity <= class9_activity_in;
            class10_activity <= class10_activity_in;
            class11_activity <= class11_activity_in;
            class12_activity <= class12_activity_in;
            class13_activity <= class13_activity_in;
            class14_activity <= class14_activity_in;
            class15_activity <= class15_activity_in;
            class16_activity <= class16_activity_in;
            class17_activity <= class17_activity_in;
            class18_activity <= class18_activity_in;
            class19_activity <= class19_activity_in;
            class20_activity <= class20_activity_in;
            class21_activity <= class21_activity_in;
            class22_activity <= class22_activity_in;
            class23_activity <= class23_activity_in;        
            class24_activity <= class24_activity_in;
            class25_activity <= class25_activity_in;
            class26_activity <= class26_activity_in;
            class27_activity <= class27_activity_in;
            class28_activity <= class28_activity_in;
            class29_activity <= class29_activity_in;
            class30_activity <= class30_activity_in;
            class31_activity <= class31_activity_in;
        end
    end  

endmodule