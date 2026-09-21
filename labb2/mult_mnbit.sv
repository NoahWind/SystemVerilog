module mult_mnbit #(
    parameter M = 4,
    parameter N = 4
)(
    input  logic [M-1:0]   a,
    input  logic [N-1:0]   b,
    output logic [M+N-1:0] product
);
    logic [M-1:0][N-1:0] pp;

    genvar i, j;
    generate
        for (i = 0; i < M; i++) begin : gen_pp_row
            for (j = 0; j < N; j++) begin : gen_pp_col
                and (pp[i][j], a[i], b[j]);
            end
        end
    endgenerate

    assign product[0] = pp[0][0];

    logic [M-1:0][N-1:0] acc_sum;
    logic [M-1:0]  acc_cout;

    assign acc_sum[0]  = pp[0];
    assign acc_cout[0] = 1'b0;

    generate
        for (i = 1; i < M; i++) begin : gen_rows
            logic [N-1:0] rca_in_a;
            assign rca_in_a = {acc_cout[i-1], acc_sum[i-1][N-1:1]};

            logic [N-1:0] rca_in_b;
            assign rca_in_b = pp[i];

            rca #(.N(N)) rca_row (
                .a(rca_in_a),
                .b(rca_in_b),
                .cin(1'b0),
                .sum(acc_sum[i]),
                .cout(acc_cout[i])
            );

            assign product[i] = acc_sum[i][0];
        end
    endgenerate

    assign product[M+N-2 : M] = acc_sum[M-1][N-1:1];
    assign product[M+N-1]     = acc_cout[M-1];

endmodule