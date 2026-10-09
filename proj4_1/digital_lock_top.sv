module digital_lock_top (
    input  logic CLK_100MHZ,
    input  logic [1:0] BTN,
    input  logic [3:0] SW,

    output logic        LED
);

    logic rstn;
    logic divided_clk;
    logic debounced_valid_key;
    logic valid_key;
    logic lock_state;


    assign rstn = ~BTN[0];

    clock_divider clk_div_inst (
        .clk(CLK_100MHZ),
        .rstn(rstn),
        .divided_clk(divided_clk)
    );


    debounce_register debounce_inst (
        .divided_clk(divided_clk),
        .rstn(rstn),
        .valid_key_BTN(BTN[1]),
        .debounced_valid_key(debounced_valid_key)
    );

    key_press_detector key_detector_inst (
        .clk(CLK_100MHZ),
        .rstn(rstn),
        .debounced_valid_key(debounced_valid_key),
        .valid_key(valid_key)
    );

    digital_lock #(
    ) lock_inst (
        .clk(CLK_100MHZ),
        .rstn(rstn),
        .key(SW),
        .valid_key(valid_key),
        .state(lock_state)
    );

    assign LED = lock_state;

endmodule