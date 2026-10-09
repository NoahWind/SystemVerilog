module traffic_light_top (
    input  logic CLK_100MHZ,
    input  logic [3:0] BTN,
    output logic [2:0] RGB0
);

    logic slow_clk;
    logic rstn;

    logic red;
    logic orange;
    logic green;

    assign rstn = ~BTN[0];

    clock_divider clk_div_inst (
    .clk(CLK_100MHZ),
    .rstn(rstn),
    .divided_clk(slow_clk)
    );

    traffic_light #(
        .RED_DELAY(5),
        .RED_ORANGE_DELAY(2),
        .GREEN_DELAY(7),
        .ORANGE_DELAY(2),
        .COUNTER_WIDTH(8)
    ) traffic_light_inst (
        .clk(slow_clk),
        .rstn(rstn),
        .red(red),
        .orange(orange),
        .green(green)
    );

    assign RGB0[0] = red;
    assign RGB0[1] = green;
    assign RGB0[2] = orange;

endmodule