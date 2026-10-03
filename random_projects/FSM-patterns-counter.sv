module seq_detector (
    input logic clk,
    input logic rst_n,
    input logic x,
    output logic z
);

typedef enum logic [1:0] {
    S_RESET,
    S_1,
    S_10,
    S_101
} state_t;

state_t pres_state;
state_t next_state;

always_ff @(posedge clk or negedge rst_n)begin
    if (!rst_n) begin
        pres_state <= S_RESET;
    end

    else begin
        pres_state <= next_state;
    end
    
end

always_comb begin
    z = 1'b0;

    case (pres_state)

    S_RESET: begin
        if (x == 1'b1)begin
            next_state = S_1;
        end
        else begin
            next_state = S_RESET;
        end
    end
        S_1: begin
        if (x == 1'b0)begin
            next_state = S_10;
        end
        else begin
            next_state = S_1;
        end
    end
        S_10: begin
        if (x == 1'b1)begin
            next_state = S_101;
        end
        else begin
            next_state = S_RESET;
        end
    end
        S_101: begin
        z = 1'b1;
        if (x == 1'b1)begin
            next_state = S_1;
        end
        else begin
        next_state = S_RESET;
        end
    end

    default: begin
        next_state = S_RESET;
    end

    endcase
end

endmodule