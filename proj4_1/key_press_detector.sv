module key_press_detector (
    input  logic clk,
    input  logic rstn,
    input  logic debounced_valid_key,
    output logic valid_key
);

    typedef enum logic {
        RELEASED,
        PRESSED
    } state_t;

    state_t state;

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state     <= RELEASED;
            valid_key <= 1'b0;
        end

        else begin

            valid_key <= 1'b0;

            case (state)

                RELEASED: begin

                    if (debounced_valid_key) begin
                        state <= PRESSED;
                        valid_key <= 1'b1;
                    end

                end


                PRESSED: begin

                    if (!debounced_valid_key) begin
                        state <= RELEASED;
                    end

                end


                default: begin
                    state <= RELEASED;
                end

            endcase

        end
    end

endmodule