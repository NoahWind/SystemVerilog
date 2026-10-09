module fins_13_5 (
    input logic clk,
    input logic rst_n,
    input logic x,
    output logic y
);

typedef enum logic [1:0] {
A,C,E,H
} state_t;

state_t current;
state_t next;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current <= A;
    end
    else begin
        current <= next;
    end
end

always_comb begin
    y=0;
    next = A;
    case(current)

    A: begin
    next = C;
    end

    C: begin
        if ( x == 0) begin
            next = C;
        end
        else begin
            next = E;
        end
    end

    E: begin
        if ( x == 0) begin
            next = H;
        end
        else begin
            next = E;
        end
    end

    H: begin
        if ( x == 0) begin
        next = C;
        end
        else begin
            next = E;
            y = 1;
        end
    end

    endcase
end

endmodule