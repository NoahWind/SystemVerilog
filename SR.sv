module gated_sr_latch (
    input logic s,
    input logic r,
    input logic e,
    output logic q,
    output logic qb
);

logic s_n, r_n;

assign s_n = ~(s & e);
assign r_n = ~(r & e);

logic n1, n2;

assign n2 = ~(s_n & n1);
assign n1 = ~(r_n & n2);

assign q  = n2;
assign qb = n1;

endmodule