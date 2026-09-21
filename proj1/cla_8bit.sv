module carry_logic_1 (
    input logic p0, p1,
    input logic g0, g1,
    input logic carry_in,
    output logic carry_out
);
    logic ng1, w1, w2;

    nand2 n_ng1(.a(g1), .b(g1), .y(ng1));
    nand2 n_w1 (.a(p1), .b(g0), .y(w1));
    nand3 n_w2 (.a(p1), .b(p0), .c(carry_in), .y(w2));

    nand3 n_final (.a(ng1), .b(w1), .c(w2), .y(carry_out));
endmodule

module carry_logic_2 (
    input logic p0, p1, p2,
    input logic g0, g1, g2,
    input logic carry_in,
    output logic carry_out
);
    logic ng2, w1, w2, w3;

    nand2 n_ng2 (.a(g2), .b(g2), .y(ng2));
    nand2 n_w1 (.a(p2), .b(g1), .y(w1));
    nand3 n_w2 (.a(p2), .b(p1), .c(g0), .y(w2));
    nand4 n_w3 (.a(p2), .b(p1), .c(p0), .d(carry_in), .y(w3));

    nand4 n_final (.a(ng2), .b(w1), .c(w2), .d(w3), .y(carry_out));
endmodule

module carry_logic_3 (
    input logic p0, p1, p2, p3,
    input logic g0, g1, g2, g3,
    input logic carry_in,
    output logic carry_out
);
    logic ng3, w1, w2, w3, w4;

    nand2 n_ng3(.a(g3), .b(g3), .y(ng3));
    nand2 n_w1 (.a(p3), .b(g2), .y(w1));
    nand3 n_w2 (.a(p3), .b(p2), .c(g1), .y(w2));
    nand4 n_w3 (.a(p3), .b(p2), .c(p1), .d(g0), .y(w3));
    nand5_delay n_w4 (.a(p3), .b(p2), .c(p1), .d(p0), .e(carry_in), .y(w4));

    nand5_delay n_final (.a(ng3), .b(w1), .c(w2), .d(w3), .e(w4), .y(carry_out));
endmodule

module carry_logic_4 (
    input logic p0, p1, p2, p3, p4,
    input logic g0, g1, g2, g3, g4,
    input logic carry_in,
    output logic carry_out
);
    logic ng4, w1, w2, w3, w4, w5;

    nand2 n_ng4(.a(g4), .b(g4), .y(ng4));
    nand2 n_w1 (.a(p4), .b(g3), .y(w1));
    nand3 n_w2 (.a(p4), .b(p3), .c(g2), .y(w2));
    nand4 n_w3 (.a(p4), .b(p3), .c(p2), .d(g1), .y(w3));
    nand5_delay n_w4 (.a(p4), .b(p3), .c(p2), .d(p1), .e(g0), .y(w4));
    nand6_delay n_w5 (.a(p4), .b(p3), .c(p2), .d(p1), .e(p0), .f(carry_in), .y(w5));

    nand6_delay n_final (.a(ng4), .b(w1), .c(w2), .d(w3), .e(w4), .f(w5), .y(carry_out));
endmodule

module carry_logic_5 (
    input logic p0, p1, p2, p3, p4, p5,
    input logic g0, g1, g2, g3, g4, g5,
    input logic carry_in,
    output logic carry_out
);
    logic ng5, w1, w2, w3, w4, w5, w6;

    nand2 n_ng5 (.a(g5), .b(g5), .y(ng5));
    nand2 n_w1 (.a(p5), .b(g4), .y(w1));
    nand3 n_w2 (.a(p5), .b(p4), .c(g3), .y(w2));
    nand4 n_w3 (.a(p5), .b(p4), .c(p3), .d(g2), .y(w3));
    nand5_delay n_w4 (.a(p5), .b(p4), .c(p3), .d(p2), .e(g1), .y(w4));
    nand6_delay n_w5 (.a(p5), .b(p4), .c(p3), .d(p2), .e(p1), .f(g0), .y(w5));
    nand7_delay n_w6 (.a(p5), .b(p4), .c(p3), .d(p2), .e(p1), .f(p0), .g(carry_in), .y(w6));

    nand7_delay n_final (.a(ng5), .b(w1), .c(w2), .d(w3), .e(w4), .f(w5), .g(w6), .y(carry_out));
endmodule

module carry_logic_6 (
    input logic p0, p1, p2, p3, p4, p5, p6,
    input logic g0, g1, g2, g3, g4, g5, g6,
    input logic carry_in,
    output logic carry_out
);
    logic ng6, w1, w2, w3, w4, w5, w6, w7;

    nand2 n_ng6 (.a(g6), .b(g6), .y(ng6));
    nand2 n_w1 (.a(p6), .b(g5), .y(w1));
    nand3 n_w2 (.a(p6), .b(p5), .c(g4), .y(w2));
    nand4 n_w3 (.a(p6), .b(p5), .c(p4), .d(g3), .y(w3));
    nand5_delay n_w4 (.a(p6), .b(p5), .c(p4), .d(p3), .e(g2), .y(w4));
    nand6_delay n_w5 (.a(p6), .b(p5), .c(p4), .d(p3), .e(p2), .f(g1), .y(w5));
    nand7_delay n_w6 (.a(p6), .b(p5), .c(p4), .d(p3), .e(p2), .f(p1), .g(g0), .y(w6));
    nand8_delay n_w7 (.a(p6), .b(p5), .c(p4), .d(p3), .e(p2), .f(p1), .g(p0), .h(carry_in), .y(w7));

    nand8_delay n_final(.a(ng6), .b(w1), .c(w2), .d(w3), .e(w4), .f(w5), .g(w6), .h(w7), .y(carry_out));
endmodule

module carry_logic_7 (
    input logic p0, p1, p2, p3, p4, p5, p6, p7,
    input logic g0, g1, g2, g3, g4, g5, g6, g7,
    input logic carry_in,
    output logic carry_out
);
    logic ng7, w1, w2, w3, w4, w5, w6, w7, w8;

    nand2 n_ng7 (.a(g7), .b(g7), .y(ng7));
    nand2 n_w1 (.a(p7), .b(g6), .y(w1));
    nand3 n_w2(.a(p7), .b(p6), .c(g5), .y(w2));
    nand4 n_w3 (.a(p7), .b(p6), .c(p5), .d(g4), .y(w3));
    nand5_delay n_w4 (.a(p7), .b(p6), .c(p5), .d(p4), .e(g3), .y(w4));
    nand6_delay n_w5 (.a(p7), .b(p6), .c(p5), .d(p4), .e(p3), .f(g2), .y(w5));
    nand7_delay n_w6 (.a(p7), .b(p6), .c(p5), .d(p4),.e(p3), .f(p2), .g(g1), .y(w6));
    nand8_delay n_w7 (.a(p7), .b(p6), .c(p5), .d(p4), .e(p3), .f(p2), .g(p1), .h(g0), .y(w7));
    nand9_delay n_w8 (.a(p7), .b(p6), .c(p5), .d(p4), .e(p3), .f(p2), .g(p1), .h(p0), .i(carry_in), .y(w8));

    nand9_delay n_final (.a(ng7), .b(w1), .c(w2), .d(w3), .e(w4), .f(w5), .g(w6), .h(w7), .i(w8), .y(carry_out));
endmodule

module cla_8bit (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] sum
);
    logic [7:0] p, g;
    logic [8:1] c;

    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : gen_pg
            propagate_logic pl (.a(a[i]), .b(b[i]), .p(p[i]));
            generate_logic gl (.a(a[i]), .b(b[i]), .g(g[i]));
        end
    endgenerate

    carry_logic_0 cl0 (.p0(p[0]), .g0(g[0]), .carry_in0(1'b0), .carry_out(c[1]));
    carry_logic_1 cl1 (.p0(p[0]), .p1(p[1]), .g0(g[0]), .g1(g[1]), .carry_in(1'b0), .carry_out(c[2]));
    carry_logic_2 cl2 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .carry_in(1'b0), .carry_out(c[3]));
    carry_logic_3 cl3 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .g3(g[3]), .carry_in(1'b0), .carry_out(c[4]));
    carry_logic_4 cl4 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]), .p4(p[4]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .g3(g[3]), .g4(g[4]), .carry_in(1'b0), .carry_out(c[5]));
    carry_logic_5 cl5 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]), .p4(p[4]), .p5(p[5]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .g3(g[3]), .g4(g[4]), .g5(g[5]), .carry_in(1'b0), .carry_out(c[6]));
    carry_logic_6 cl6 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]), .p4(p[4]), .p5(p[5]), .p6(p[6]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .g3(g[3]), .g4(g[4]), .g5(g[5]), .g6(g[6]), .carry_in(1'b0), .carry_out(c[7]));
    carry_logic_7 cl7 (.p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]), .p4(p[4]), .p5(p[5]), .p6(p[6]), .p7(p[7]), .g0(g[0]), .g1(g[1]), .g2(g[2]), .g3(g[3]), .g4(g[4]), .g5(g[5]), .g6(g[6]), .g7(g[7]), .carry_in(1'b0), .carry_out(c[8]));

    sum_logic sl0 (.a(a[0]), .b(b[0]), .carry_in(1'b0), .sum(sum[0]));
    sum_logic sl1 (.a(a[1]), .b(b[1]), .carry_in(c[1]), .sum(sum[1]));
    sum_logic sl2 (.a(a[2]), .b(b[2]), .carry_in(c[2]), .sum(sum[2]));
    sum_logic sl3 (.a(a[3]), .b(b[3]), .carry_in(c[3]), .sum(sum[3]));
    sum_logic sl4 (.a(a[4]), .b(b[4]), .carry_in(c[4]), .sum(sum[4]));
    sum_logic sl5 (.a(a[5]), .b(b[5]), .carry_in(c[5]), .sum(sum[5]));
    sum_logic sl6 (.a(a[6]), .b(b[6]), .carry_in(c[6]), .sum(sum[6]));
    sum_logic sl7 (.a(a[7]), .b(b[7]), .carry_in(c[7]), .sum(sum[7]));

    sum_logic sl_sign_ext (.a(a[7]), .b(b[7]), .carry_in(c[8]), .sum(sum[8]));

endmodule
