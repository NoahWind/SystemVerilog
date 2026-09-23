module mult_add (
    input  logic [3:0] a0,
    input  logic [3:0] a1,
    input  logic [3:0] a2,
    input  logic [3:0] a3,
    input  logic [3:0] a4,
    input  logic [3:0] a5,
    input  logic [3:0] a6,
    input  logic [3:0] a7,
    output logic [9:0] x
);
    logic [7:0] p0, p1, p2, p3;

    mult_mnbit #(.M(4), .N(4)) m0 (.a(a0), .b(a1), .product(p0));
    mult_mnbit #(.M(4), .N(4)) m1 (.a(a2), .b(a3), .product(p1));
    mult_mnbit #(.M(4), .N(4)) m2 (.a(a4), .b(a5), .product(p2));
    mult_mnbit #(.M(4), .N(4)) m3 (.a(a6), .b(a7), .product(p3));

    logic [7:0] sum_s1_0, sum_s1_1;
    logic cout_s1_0, cout_s1_1;

    rca #(.N(8)) add_s1_0 (.a(p0), .b(p1), .cin(1'b0), .sum(sum_s1_0), .cout(cout_s1_0));
    rca #(.N(8)) add_s1_1 (.a(p2), .b(p3), .cin(1'b0), .sum(sum_s1_1), .cout(cout_s1_1));

    logic [8:0] term0, term1;
    assign term0 = {cout_s1_0, sum_s1_0};
    assign term1 = {cout_s1_1, sum_s1_1};

    logic [8:0] sum_s2;
    logic cout_s2;

    rca #(.N(9)) add_s2 (.a(term0), .b(term1), .cin(1'b0), .sum(sum_s2), .cout(cout_s2));

    assign x = {cout_s2, sum_s2};

endmodule
