
module sum_logic (
input logic a,
input logic b,
input logic carry_in,
output logic sum);

logic nd1;

xor2 xora( .a(a), .b(b), .p(nd1));
xor2 xorb( .a(carry_in), .b(nd1), .p(sum));


endmodule