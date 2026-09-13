
module mux2 (
    input logic d0,
    input logic d1,
    input logic sel,
    output logic y
);
    logic nsel;
    logic w1, w2;

    nand2 inv_s (.a(sel),  .b(sel),  .y(nsel));
    nand2 n_d0  (.a(d0),   .b(nsel), .y(w1));
    nand2 n_d1  (.a(d1),   .b(sel),  .y(w2));
    nand2 n_out (.a(w1),   .b(w2),   .y(y));
endmodule