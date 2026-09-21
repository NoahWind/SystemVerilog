module xor2 (
input logic a,
input logic b,
output logic p);

logic nd1,nd2,nd3;

nand2 nana1( .a(a),.b(b),.y(nd1));
nand2 nana2(.a(a),.b(nd1),.y(nd2));
nand2 nana3( .a(b),.b(nd1),.y(nd3));
nand2 nana4( .a(nd2),.b(nd3),.y(p));

endmodule