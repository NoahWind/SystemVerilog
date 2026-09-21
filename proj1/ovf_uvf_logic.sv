
module ovf_uvf_logic (
    input logic a7,
    input logic b7,
    input logic sum7,
    output logic ovf,
    output logic uvf
);
    logic na7, nb7, nsum7;
    logic ovf_bar, uvf_bar;

    nand2 inv_a  (.a(a7),.b(a7),   .y(na7));
    nand2 inv_b  (.a(b7),   .b(b7),.y(nb7));
    nand2 inv_s  (.a(sum7), .b(sum7),.y(nsum7));

    nand3 n_ovf  (.a(na7),  .b(nb7),  .c(sum7), .y(ovf_bar));
    nand2 i_ovf  (.a(ovf_bar), .b(ovf_bar), .y(ovf));

    nand3 n_uvf  (.a(a7),.b(b7),   .c(nsum7), .y(uvf_bar));
    nand2 i_uvf  (.a(uvf_bar), .b(uvf_bar),.y(uvf));
endmodule