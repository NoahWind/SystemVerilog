module dec1101(
    input logic x,
    input logic clk,
    input logic rst_n,
    output logic y
);

typedef enum logic [1:0] {
    S0,
    S1,
    S2,
    S3
} state;

state current;
state next;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current <= S0;
    end
    else begin
        current <= next;
    end
end

always_comb begin
    next = S0;
    y = 0;
    case(current)
    S0: begin
        if (x== 1'b1) begin
            next = S1;
        end
        else begin
            next = S0; 
        end
    end
    S1: begin
        if ( x== 1'b1 ) begin
            next = S2;
        end
        else begin
            next = S0;
        end
    end

    S2: begin
        if (x== 1'b1) begin
            next = S2;
        end
        else begin
            next = S3;
        end
    end

    S3: begin
        if (x==1'b1) begin
            y = 1;
            next = S1;
        end
        else begin
            next = S0;
        end
    end

    endcase
end

endmodule