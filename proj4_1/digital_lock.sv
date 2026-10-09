module digital_lock #(parameter logic [15:0] DEFAULT_PIN = 16'h1234
)(
    input  logic clk,
    input  logic rstn,
    input  logic [3:0] key,
    input  logic valid_key,
    output logic state
);

    typedef enum logic [1:0] {
        UNLOCKED,
        LOCKED,
        ENTER_PIN,
        CHANGE_PIN
    } state_t;

    state_t current_state;
    logic [15:0] password;
    logic [15:0] entered_pin;
    logic [2:0] digit_count;

    always_ff @(posedge clk or negedge rstn) begin

        if (!rstn) begin
            current_state <= UNLOCKED;
            password <= 16'h1234;
            entered_pin <= 16'h0000;
            digit_count <= 3'd0;
        end

        else if (valid_key) begin

            case (current_state)

                UNLOCKED: begin
                    entered_pin <= 16'h0000;
                    digit_count <= 3'd0;

                    if (key == 4'hB) begin
                        current_state <= LOCKED;
                    end

                    else if (key == 4'hE) begin
                        current_state <= CHANGE_PIN;
                    end
                end

                LOCKED: begin
                    entered_pin <= {12'h000, key}; // Store first entered PIN digit
                    digit_count <= 3'd1;
                    current_state <= ENTER_PIN;
                end

                ENTER_PIN: begin

                    if (digit_count < 4) begin
                        entered_pin <= {entered_pin[11:0], key}; // shift shift shift

                        digit_count <= digit_count + 1'b1;
                    end

                    else begin

                        if ((key == 4'hC) &&
                            (entered_pin == password)) begin
                            current_state <= UNLOCKED;
                        end
                        else begin
                            current_state <= LOCKED;
                        end

                        entered_pin <= 16'h0000;
                        digit_count <= 3'd0;
                    end
                end


                CHANGE_PIN: begin

                    if (digit_count == 3) begin
                        password <= {
                            entered_pin[11:0],
                            key
                        };

                        entered_pin <= 16'h0000;
                        digit_count <= 3'd0;
                        current_state <= UNLOCKED;
                    end

                    else begin
                        entered_pin <= {
                            entered_pin[11:0],
                            key
                        };

                        digit_count <= digit_count + 1'b1;
                    end
                end
                default: begin
                    current_state <= UNLOCKED;
                    entered_pin   <= 16'h0000;
                    digit_count   <= 3'd0;
                end

            endcase
        end
    end


    always_comb begin
        case (current_state)
            LOCKED,
            ENTER_PIN:
                state = 1'b1;
            default:
                state = 1'b0;

        endcase
    end

endmodule