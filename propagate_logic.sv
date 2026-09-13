
module propagate_logic (
input logic a,
input logic b,
output logic p);

logic na, nb;

nand2 nana( .a(a), .b(a), .y(na));
nand2 nanb( .a(b), .b(b), .y(nb));
nand2 nanp( .a(na), .b(nb), .y(p));

endmodule
