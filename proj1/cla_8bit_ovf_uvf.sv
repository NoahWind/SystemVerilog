module cla_8bit_ovf_uvf (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] sum,
    output logic ovf,
    output logic uvf
);
    logic [8:0] sum_full;
    logic unused_sum8;

    cla_8bit adder (
        .a(a),
        .b(b),
        .sum({unused_sum8, sum})
    );

    ovf_uvf_logic ovf_uvf_inst (
        .a7(a[7]),
        .b7(b[7]),
        .sum7(sum[7]),
        .ovf(ovf),
        .uvf(uvf)
    );

endmodule