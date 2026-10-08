module clock_divider #(
    parameter integer DIVISOR = 100_000_000
)(
    input  logic clk,
    input  logic rstn,

    output logic divided_clk
);

    localparam integer COUNTER_WIDTH = $clog2(DIVISOR);

    logic [COUNTER_WIDTH-1:0] counter;

    always_ff @(posedge clk or negedge rstn) begin

        if (!rstn) begin
            counter <= '0;
            divided_clk <= 1'b0;
        end

        else begin

            if (counter == (DIVISOR / 2) - 1) begin

                counter <= '0;
                divided_clk <= ~divided_clk;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
