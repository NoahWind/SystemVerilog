module generate_logic (
    input logic a,
    input logic b,
    output logic g
);
    logic na;

    nand2 nan1 (.a(a), .b(b), .y(na));
    nand2 nan2 (.a(na), .b(na), .y(g));
endmodule
