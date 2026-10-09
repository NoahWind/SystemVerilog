module door_controller ( 
    input  logic clk,
    input  logic rst_n,
    input  logic request,
    output logic open
);

typedef enum logic [1:0]{
    CLOSED,
    OPENING,
    OPEN
} state_t;

state_t next_state;
state_t pres_state;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pres_state <= CLOSED;
    end
    else begin
        pres_state <= next_state;
    end
end

always_comb begin
    case ({pres_state})
    CLOSED: begin
        open = 1'b0;
        if (request) begin
            next_state = OPENING;
        end
        else begin
            next_state = CLOSED;
        end
    end

    OPENING: begin
        open = 1'b0;
        next_state = OPEN;
    end

    OPEN: begin
        open = 1'b1;
        if (request) begin
            next_state = OPEN;
        end
        else begin
            next_state = CLOSED;
        end
    end

    endcase
end

endmodule
