module cla_8bit_sat_out (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] sum,
    output logic ovf,
    output logic uvf
);
    logic [8:0] sum_full;
    logic [7:0] mux1_out;

    cla_8bit adder (
        .a(a),
        .b(b),
        .sum(sum_full)
    );

    ovf_uvf_logic ovf_uvf_inst (
        .a7(a[7]),
        .b7(b[7]),
        .sum7(sum_full[7]),
        .ovf(ovf),
        .uvf(uvf)
    );

    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : gen_sat_muxes
            if (i == 7) begin : msb_clamp
                mux2 mux_ovf (
                    .d0(sum_full[i]),
                    .d1(1'b0),
	          .sel(ovf),
                    .y(mux1_out[i])
                );

                mux2 mux_uvf (
                    .d0(mux1_out[i]),
                    .d1(1'b1),
                   .sel(uvf),
                    .y(sum[i])
                );
            end else begin :lsb_clamp
                mux2 mux_ovf (
                    .d0(sum_full[i]),
                    .d1(1'b1),
                    .sel(ovf),
                    .y(mux1_out[i])
                );

                mux2 mux_uvf (
                    .d0(mux1_out[i]),
                    .d1(1'b0),
                    .sel(uvf),
                    .y(sum[i])
                );
            end
        end
    endgenerate
endmodule