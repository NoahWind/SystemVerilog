module comp_cell_1bit (
    input  logic a,
    input  logic b,
    output logic g, 
    output logic e, 
    output logic l  
);  assign g = a & ~b;
    assign e = ~(a ^ b);
    assign l = ~a & b;
endmodule



module comp_merge_node (
    input logic g_h, e_h, l_h, 
    input  logic g_l, e_l, l_l, 
    output logic g_out, e_out, l_out
);
    assign g_out = g_h | (e_h & g_l);
    assign e_out = e_h & e_l;
    assign l_out = l_h | (e_h & l_l);
endmodule





module comparator_unit (
    input  logic [7:0] x,
    input  logic [7:0] y,
    input  logic [1:0] m,
    output logic [15:0] z
);

    logic [7:0] g0, e0, l0;
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : gen_level0
            comp_cell_1bit u_cell (
                .a(x[i]),
                .b(y[i]),
                .g(g0[i]),
                .e(e0[i]),
                .l(l0[i])
            );
        end
    endgenerate

    logic [3:0] g1, e1, l1;
    genvar j;
    generate
        for (j = 0; j < 4; j++) begin : gen_level1
            comp_merge_node m1 (
                .g_h(g0[2*j+1]), .e_h(e0[2*j+1]), .l_h(l0[2*j+1]),
                .g_l(g0[2*j]), .e_l(e0[2*j]),.l_l(l0[2*j]),
                .g_out(g1[j]), .e_out(e1[j]), .l_out(l1[j])
            );
        end
    endgenerate

    logic [1:0] g2, e2, l2;
    genvar k;
    generate
        for (k = 0; k < 2; k++) begin : gen_level2
            comp_merge_node m2 (
                .g_h(g1[2*k+1]), .e_h(e1[2*k+1]), .l_h(l1[2*k+1]),
                .g_l(g1[2*k]), .e_l(e1[2*k]),.l_l(l1[2*k]),
                .g_out(g2[k]), .e_out(e2[k]), .l_out(l2[k])
            );
        end
    endgenerate

    logic is_gt, is_eq, is_lt;
    comp_merge_node m3 (
        .g_h(g2[1]), .e_h(e2[1]), .l_h(l2[1]),
        .g_l(g2[0]), .e_l(e2[0]), .l_l(l2[0]),
        .g_out(is_gt), .e_out(is_eq), .l_out(is_lt)
    );

    logic result;
    mux4to1 #(.WIDTH(1)) comp_mux (
        .in0(is_gt),
        .in1(is_lt),
        .in2(is_eq),
        .in3(~is_eq), 
        .sel(m),
        .out(result)
    );
    assign z = {15'b0, result};

endmodule