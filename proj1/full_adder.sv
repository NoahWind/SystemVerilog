module full_adder (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
    logic axorb;
    logic aandb;
    logic cin_and_axorb;

    xor g1 (axorb, a, b);
    xor g2 (sum, axorb, cin);     

    and g3 (aandb, a, b);
    and g4 (cin_and_axorb, cin, axorb);
    or  g5 (cout, aandb, cin_and_axorb);

endmodule