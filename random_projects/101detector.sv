module detector101 (
    input logic clk,
    input logic x,
    input logic rst_n,
    output logic detect
);

typedef enum logic[1:0] {
    S0,
    S1,
    S2
} state;

state current;
state next;

always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        current <= S0;
    end
    else begin
        current <= next;
    end
end

always_comb begin

    detect = 0;

    case(current)
    S0: begin
        if ( x== 1'b0) begin
            next = S0;
        end
        else begin
            next = S1;
        end
    end

    S1: begin
        if ( x == 1'b1) begin
            next = S1;
        end
        else begin
            next = S2;
        end
    end

    S2: begin
        if ( x == 1'b1) begin
            next = S1;
            detect = 1;
        end
        else begin
            next = S0;
        end
    end

    endcase
        
end

endmodule