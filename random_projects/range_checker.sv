module compare_ge ( 
    input  logic [3:0] X,
    input  logic [3:0] Y,
    output logic ge
);

always_comb begin
    if(X>=Y) begin
        ge = 1'b1;
    end
    else begin
        ge = 1'b0;
    end
end
endmodule

module range_checker (
    input  logic [3:0] X,
    input  logic [3:0] LOW,
    input  logic [3:0] HIGH,
    output logic in_range
);

logic is_not_to_big;
logic is_not_to_small;
compare_ge comp_high (.X(HIGH), .Y(X), .ge(is_not_to_big));
compare_ge comp_low (.X(X), .Y(LOW), .ge(is_not_to_small));

    always_comb begin
        if (is_not_to_big & is_not_to_small) begin
            in_range = 1'b1;
        end
        else begin
            in_range = 1'b0;
        end
    end

endmodule