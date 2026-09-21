
module mux21 (
    input  logic a,
    input  logic b,
    input  logic s,
    output logic y
);
    assign y = s ? b : a;
endmodule

module fa_mux (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
    logic a_xor_b;
    logic not_cin;

    mux21 mux_xor (
        .a(b),
        .b(~b),
        .s(a),
        .y(a_xor_b)
    );

    mux21 mux_inv (
        .a(1'b1),
        .b(1'b0),
        .s(cin),
        .y(not_cin)
    );

    mux21 mux_sum (
        .a(cin),
        .b(not_cin),
        .s(a_xor_b),
        .y(sum)
    );

    mux21 mux_cout (
        .a(b),
        .b(cin),
        .s(a_xor_b),
        .y(cout)
    );

endmodule

module rca_nbit_mux #(
    parameter N = 4
)(
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    input  logic         cin,
    output logic [N-1:0] sum,
    output logic         cout
);
    logic [N:0] c;
    assign c[0] = cin;

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_rca_mux
            fa_mux fa_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate

    assign cout = c[N];

endmodule