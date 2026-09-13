
module nand2 (
    input logic a,
    input logic b,
    output logic y
);
    assign #(1.0) y = ~(a & b);
endmodule

module nand3 (
    input logic a,
    input logic b,
    input logic c,
    output logic y
);
    assign #(1.25) y = ~(a & b & c);
endmodule

module nand4 (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic y
);
    assign #(1.5) y = ~(a & b & c & d);
endmodule

