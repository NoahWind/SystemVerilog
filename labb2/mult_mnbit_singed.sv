module mult_mnbit_signed #(
    parameter M = 4,
    parameter N = 4
)(
    input  logic [M-1:0]   a,
    input  logic [N-1:0]   b,
    output logic [M+N-1:0] product
);
    logic [N-1:0][M-1:0] pp;

    genvar j, i;
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

    assign product[0] = pp[0][0];

    logic [N-2:0][M-1:0] sum_wire;
    logic [N-2:0] cout_wire;

    logic [M-1:0] rca0_in_a;
    assign rca0_in_a = {1'b1, pp[0][M-1:1]};

    logic [M-1:0] rca0_in_b;
    assign rca0_in_b = pp[1];

    rca #(.N(M)) rca_row0 (
        .a(rca0_in_a),
        .b(rca0_in_b),
        .cin(1'b0),
        .sum(sum_wire[0]),
        .cout(cout_wire[0])
    );

    assign product[1] = sum_wire[0][0];

    generate
        for (j = 1; j < N-1; j++) begin : gen_adder_rows
            logic [M-1:0] rca_in_a;
            assign rca_in_a = {cout_wire[j-1], sum_wire[j-1][M-1:1]}; 

            logic [M-1:0] rca_in_b;
            assign rca_in_b = pp[j+1]; 

            logic rca_cin;
            assign rca_cin = 1'b0;

            rca #(.N(M)) rca_row (
                .a(rca_in_a),
                .b(rca_in_b),
                .cin(rca_cin),
                .sum(sum_wire[j]),
                .cout(cout_wire[j])
            );

            assign product[j+1] = sum_wire[j][0];
        end
    endgenerate

    assign product[M+N-2 : N] = sum_wire[N-2][M-1:1]; 
    assign product[M+N-1] = ~cout_wire[N-2]; // HA

endmodule