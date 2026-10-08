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

    logic [COUNTER_WIDTH-1:0] counter;


    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state   <= RED_STATE;
            counter <= RED_DELAY - 1;
        end 

        else begin
            if (counter == 0) begin

                case (state)

                    RED_STATE: begin
                        state   <= RED_ORANGE_STATE;
                        counter <= RED_ORANGE_DELAY - 1;
                    end

                    RED_ORANGE_STATE: begin
                        state   <= GREEN_STATE;
                        counter <= GREEN_DELAY - 1;
                    end

                    GREEN_STATE: begin
                        state   <= ORANGE_STATE;
                        counter <= ORANGE_DELAY - 1;
                    end

                    ORANGE_STATE: begin
                        state   <= RED_STATE;
                        counter <= RED_DELAY - 1;
                    end

                    default: begin
                        state   <= RED_STATE;
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

        case (state)

            RED_STATE: begin
                red = 1'b1;
            end

            RED_ORANGE_STATE: begin
                red    = 1'b1;
                orange = 1'b1;
            end

            GREEN_STATE: begin
                green = 1'b1;
            end

            ORANGE_STATE: begin
                orange = 1'b1;
            end

            default: begin
                red = 1'b1;
            end

        endcase
    end

endmodule