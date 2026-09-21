module nand5_delay (
    input logic a, b, c, d, e,
    output logic y
);
    logic w1, w1_and;

    nand4 n1 (.a(a), .b(b), .c(c), .d(d), .y(w1));
    nand2 inv1 (.a(w1), .b(w1), .y(w1_and));
    nand2 n_final (.a(w1_and), .b(e), .y(y));
endmodule

module nand6_delay (
    input logic a, b, c, d, e, f,
    output logic y
);
    logic w1, w1_and;

    nand4 n1 (.a(a), .b(b), .c(c), .d(d), .y(w1));
    nand2 inv1 (.a(w1), .b(w1), .y(w1_and));
    nand3 n_final (.a(w1_and), .b(e), .c(f), .y(y));
endmodule

module nand7_delay (
    input logic a, b, c, d, e, f, g,
    output logic y
);
    logic w1, w1_and;

    nand4 n1 (.a(a), .b(b), .c(c), .d(d), .y(w1));
    nand2 inv1 (.a(w1), .b(w1), .y(w1_and));
    nand4 n_final (.a(w1_and), .b(e), .c(f), .d(g), .y(y));
endmodule

module nand8_delay (
    input logic a, b, c, d, e, f, g, h,
    output logic y
);
    logic w1, w2, w1_and, w2_and;

    nand4 n1 (.a(a), .b(b), .c(c), .d(d), .y(w1));
    nand2 inv1 (.a(w1), .b(w1), .y(w1_and));
    nand4 n2 (.a(e), .b(f), .c(g), .d(h), .y(w2));
    nand2 inv2 (.a(w2), .b(w2), .y(w2_and));
    nand2 n_final (.a(w1_and), .b(w2_and), .y(y));
endmodule

module nand9_delay (
    input logic a, b, c, d, e, f, g, h, i,
    output logic y
);
    logic w1, w2, w1_and, w2_and;

    nand4 n1 (.a(a), .b(b), .c(c), .d(d), .y(w1));
    nand2 inv1 (.a(w1), .b(w1), .y(w1_and));
    nand4 n2 (.a(e), .b(f), .c(g), .d(h), .y(w2));
    nand2 inv2 (.a(w2), .b(w2), .y(w2_and));
    nand3 n_final (.a(w1_and), .b(w2_and), .c(i), .y(y));
endmodule