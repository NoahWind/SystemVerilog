
module mult_mnbit_signed #(
    parameter M = 4, 
    parameter N = 4 
)(
    input  logic [M-1:0]   a,
    input  logic [N-1:0]   b, 
    output logic [M+N-1:0] product
);
    logic [N-1:0][M-1:0] pp;

    genvar i, j;
    generate
        for (j = 0; j < N; j++) begin : gen_pp_rows
            for (i = 0; i < M; i++) begin : gen_pp_cols
                if (((i == M-1) && (j != N-1)) || ((j == N-1) && (i != M-1))) begin : gen_nand
                    nand (pp[j][i], a[i], b[j]);
                end else begin : gen_and
                    and  (pp[j][i], a[i], b[j]);
                end
            end
        end
    endgenerate

    logic [N-2:0][M-1:0] sum_wire;
    logic [N-2:0][M-1:0] carry_wire;

    buf (product[0], pp[0][0]);

    generate
        for (i = 0; i < M; i++) begin : gen_row0
            if (i == 0) begin : gen_ha
                half_adder ha (
                    .a(pp[0][1]),
                    .b(pp[1][0]),
                    .sum(product[1]),
                    .cout(carry_wire[0][0])
                );
            end else if (i < M-1) begin : gen_fa
                full_adder fa (
                    .a(pp[0][i+1]),
                    .b(pp[1][i]),
                    .cin(carry_wire[0][i-1]),
                    .sum(sum_wire[0][i]),
                    .cout(carry_wire[0][i])
                );
            end else begin : gen_fa_top
                full_adder fa (
                    .a(1'b1),
                    .b(pp[1][M-1]),
                    .cin(carry_wire[0][M-2]),
                    .sum(sum_wire[0][M-1]),
                    .cout(carry_wire[0][M-1])
                );
            end
        end
    endgenerate

    generate
        for (j = 1; j < N-2; j++) begin : gen_mid_rows
            for (i = 0; i < M; i++) begin : gen_cols
                if (i == 0) begin : gen_ha
                    half_adder ha (
                        .a(sum_wire[j-1][1]),
                        .b(pp[j+1][0]),
                        .sum(product[j+1]),
                        .cout(carry_wire[j][0])
                    );
                end else if (i < M-1) begin : gen_fa
                    full_adder fa (
                        .a(sum_wire[j-1][i+1]),
                        .b(pp[j+1][i]),
                        .cin(carry_wire[j][i-1]),
                        .sum(sum_wire[j][i]),
                        .cout(carry_wire[j][i])
                    );
                end else begin : gen_fa_top
                    full_adder fa (
                        .a(carry_wire[j-1][M-1]),
                        .b(pp[j+1][M-1]),
                        .cin(carry_wire[j][M-2]),
                        .sum(sum_wire[j][M-1]),
                        .cout(carry_wire[j][M-1])
                    );
                end
            end
        end
    endgenerate

    generate
        for (i = 0; i < M; i++) begin : gen_last_pp_row
            if (i == 0) begin : gen_ha
                half_adder ha (
                    .a(sum_wire[N-3][1]),
                    .b(pp[N-1][0]),
                    .sum(product[N-1]),
                    .cout(carry_wire[N-2][0])
                );
            end else if (i < M-1) begin : gen_fa
                full_adder fa (
                    .a(sum_wire[N-3][i+1]),
                    .b(pp[N-1][i]),
                    .cin(carry_wire[N-2][i-1]),
                    .sum(product[N-1+i]),
                    .cout(carry_wire[N-2][i])
                );
            end else begin : gen_fa_top
                full_adder fa (
                    .a(carry_wire[N-3][M-1]),
                    .b(pp[N-1][M-1]),
                    .cin(carry_wire[N-2][M-2]),
                    .sum(product[M+N-2]), 
                    .cout(carry_wire[N-2][M-1])
                );
            end
        end
    endgenerate

    half_adder ha_final (
        .a(1'b1),
        .b(carry_wire[N-2][M-1]),
        .sum(product[M+N-1]), 
        .cout()     
    );

endmodule