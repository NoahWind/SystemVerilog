module tent(
input logic [3:0] A,
input logic [3:0] B,
output logic [3:0] ans
);

logic [4:0] sum;
always_comb begin
sum = A+B;
ans = (sum>5'b01111) ? 4'b1111 : sum[3:0];

end

endmodule