module traffic_light #(
    parameter integer RED_DELAY = 5,
    parameter integer RED_ORANGE_DELAY = 2,
    parameter integer GREEN_DELAY  = 7,
    parameter integer ORANGE_DELAY = 2,
    parameter integer COUNTER_WIDTH = 8
)(
    input  logic clk,
    input  logic rstn,
    output logic red,
    output logic orange,
    output logic green
);

    typedef enum logic [1:0] {
        RED_STATE,
        RED_ORANGE_STATE,
        GREEN_STATE,
        ORANGE_STATE
    } state_t;

    state_t state;
    state_t next_state;

    logic [COUNTER_WIDTH-1:0] counter;


    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state   <= RED_STATE;
            counter <= RED_DELAY - 1;
        end 

        else begin
            if (counter == 0) begin
                state <= next_state;
                case (state)

                    RED_STATE: begin
                        counter <= RED_ORANGE_DELAY - 1;
                    end

                    RED_ORANGE_STATE: begin
                        counter <= GREEN_DELAY - 1;
                    end

                    GREEN_STATE: begin
                        counter <= ORANGE_DELAY - 1;
                    end

                    ORANGE_STATE: begin
                        counter <= RED_DELAY - 1;
                    end

                    default: begin
                        counter <= RED_DELAY - 1;
                    end

                endcase
            end
            else begin
                counter <= counter - 1'b1;
            end
        end
    end


    always_comb begin

        red = 1'b0;
        orange = 1'b0;
        green = 1'b0;
        next_state = RED_STATE;
        case (state)

            RED_STATE: begin
                red = 1'b1;
                next_state = RED_ORANGE_STATE;
            end

            RED_ORANGE_STATE: begin
                red = 1'b1;
                orange = 1'b1;
                next_state = GREEN_STATE;
            end

            GREEN_STATE: begin
                green = 1'b1;
                next_state = ORANGE_STATE;
            end

            ORANGE_STATE: begin
                orange = 1'b1;
                next_state = RED_STATE;
            end

            default: begin
                red = 1'b1;
            end
        endcase
    end

endmodule