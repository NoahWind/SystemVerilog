
module half_adder (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);
    xor g1 (sum, a, b);
    and g2 (cout, a, b);
endmodule