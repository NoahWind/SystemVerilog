module debounce_register (
    input  logic divided_clk,
    input  logic rstn,
    input  logic valid_key_BTN,

    output logic debounced_valid_key
);

    always_ff @(posedge divided_clk or negedge rstn) begin

        if (!rstn) begin
            debounced_valid_key <= 1'b0;
        end

        else begin
            debounced_valid_key <= valid_key_BTN;
        end

    end

endmodule