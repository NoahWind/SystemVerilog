
module carry_logic_0 (
    input logic p0,
    input logic g0,
    input logic carry_in0,
    output logic carry_out
);

    logic w1;
    logic ng0;

    nand2 n1 (.a(p0), .b(carry_in0), .y(w1));
    nand2 n3 (.a(g0), .b(g0), .y(ng0));
    nand2 n4 (.a(ng0), .b(w1), .y(carry_out));

endmodule