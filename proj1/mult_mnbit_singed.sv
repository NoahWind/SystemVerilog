// ------------------------------------------------------------
// 1. Hjælpemoduler (Strukturelle)
// ------------------------------------------------------------
module half_adder (
    input  logic a, b,
    output logic sum, cout
);
    xor (sum, a, b);
    and (cout, a, b);
endmodule

module full_adder (
    input  logic a, b, cin,
    output logic sum, cout
);
    logic axorb, aandb, cin_and_axorb;

    xor (axorb, a, b);
    xor (sum, axorb, cin);

    and (aandb, a, b);
    and (cin_and_axorb, cin, axorb);
    or  (cout, aandb, cin_and_axorb);
endmodule

// ------------------------------------------------------------
// 2. Baugh-Wooley Multiplikator med genvar (N x M)
// ------------------------------------------------------------
module mult_mnbit_signed #(
    parameter M = 4, // Bredde af a (X)
    parameter N = 4  // Bredde af b (Y)
)(
    input  logic [M-1:0]   a,       // X-indgang[cite: 7]
    input  logic [N-1:0]   b,       // Y-indgang[cite: 7]
    output logic [M+N-1:0] product  // Z-udgang[cite: 7]
);
    // Grid til partialprodukter
    logic [N-1:0][M-1:0] pp;

    // Generér partialprodukter (NAND på MSB-kantelementer, AND ellers)[cite: 7]
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

    // Intern ledningsnet til sum og carry
    logic [N-2:0][M-1:0] sum_wire;
    logic [N-2:0][M-1:0] carry_wire;

    // Z0 udtages direkte fra pp[0][0][cite: 7]
    buf (product[0], pp[0][0]);

    // ------------------------------------------------------------
    // Række 1 (J = 0): Første række af adderere (HA + FA + FA_top med 1'b1)[cite: 7]
    // ------------------------------------------------------------
    generate
        for (i = 0; i < M; i++) begin : gen_row0
            if (i == 0) begin : gen_ha
                // HA til højre giver product[1] (Z1)[cite: 7]
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
                // Øverste venstre FA tager fast 1'b1 på .a indgangen[cite: 7]
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

    // ------------------------------------------------------------
    // Midterste rækker (j fra 1 til N-3)[cite: 7]
    // ------------------------------------------------------------
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

    // ------------------------------------------------------------
    // Sidste række af partialprodukter (j = N-2)[cite: 7]
    // ------------------------------------------------------------
    generate
        for (i = 0; i < M; i++) begin : gen_last_pp_row
            if (i == 0) begin : gen_ha
                half_adder ha (
                    .a(sum_wire[N-3][1]),
                    .b(pp[N-1][0]),
                    .sum(product[N-1]), // Z3 i 4x4-tilfælde[cite: 7]
                    .cout(carry_wire[N-2][0])
                );
            end else if (i < M-1) begin : gen_fa
                full_adder fa (
                    .a(sum_wire[N-3][i+1]),
                    .b(pp[N-1][i]),
                    .cin(carry_wire[N-2][i-1]),
                    .sum(product[N-1+i]), // Z4, Z5[cite: 7]
                    .cout(carry_wire[N-2][i])
                );
            end else begin : gen_fa_top
                full_adder fa (
                    .a(carry_wire[N-3][M-1]),
                    .b(pp[N-1][M-1]),
                    .cin(carry_wire[N-2][M-2]),
                    .sum(product[M+N-2]), // Z6[cite: 7]
                    .cout(carry_wire[N-2][M-1])
                );
            end
        end
    endgenerate

    // ------------------------------------------------------------
    // Afsluttende korrektions-HA nederst til venstre[cite: 7]
    // ------------------------------------------------------------
    half_adder ha_final (
        .a(1'b1),
        .b(carry_wire[N-2][M-1]),
        .sum(product[M+N-1]), // Z7[cite: 7]
        .cout()               // Unused carry-out
    );

endmodule