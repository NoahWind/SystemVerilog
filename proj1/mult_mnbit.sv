module mult_mnbit #(
    parameter M = 4,
    parameter N = 4
)(
    input  logic [M-1:0]   a,
    input  logic [N-1:0]   b,
    output logic [M+N-1:0] product
);
    // 1. Generera alla partialprodukter (M rader, Varje rad är N bitar)
    logic [M-1:0][N-1:0] pp;

    genvar i, j;
    generate
        for (i = 0; i < M; i++) begin : gen_pp_row
            for (j = 0; j < N; j++) begin : gen_pp_col
                and (pp[i][j], a[i], b[j]);
            end
        end
    endgenerate

    // Första produktbiten är direkt pp[0][0]
    assign product[0] = pp[0][0];

    // Ackumulerade summor och carries mellan raddirektionerna
    // acc_sum[i] håller den beräknade summan efter rad i
    logic [M-1:0][N-1:0] acc_sum;
    logic [M-1:0]        acc_cout;

    // Första raden (Rad 0) initierar ackumulatorn
    assign acc_sum[0]  = pp[0];
    assign acc_cout[0] = 1'b0;

    // 2. Instansiera en RCA för VARJE rad (Rad 1 till M-1)
    generate
        for (i = 1; i < M; i++) begin : gen_rows
            // Indata 'a' till RCA är den förskjutna summan från föregående rad:
            // {föregående carry, föregående summa [N-1:1]}
            logic [N-1:0] rca_in_a;
            assign rca_in_a = {acc_cout[i-1], acc_sum[i-1][N-1:1]};

            // Indata 'b' är nuvarande rads partialprodukt
            logic [N-1:0] rca_in_b;
            assign rca_in_b = pp[i];

            // Instansiera RCA för denna rad
            rca #(.N(N)) rca_row (
                .a(rca_in_a),
                .b(rca_in_b),
                .cin(1'b0),
                .sum(acc_sum[i]),
                .cout(acc_cout[i])
            );

            // Den lägsta biten ur varje RCA-steg blir en färdig bit i slutprodukten
            assign product[i] = acc_sum[i][0];
        end
    endgenerate

    // 3. De sista övre bitarna tas direkt från den sista RCA-modulen
    assign product[M+N-2 : M] = acc_sum[M-1][N-1:1];
    assign product[M+N-1]     = acc_cout[M-1];

endmodule