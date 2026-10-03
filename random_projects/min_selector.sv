module compare4(
    input logic [3:0] A,
    input logic [3:0] B,
    output logic A_is_greater
);
    always_comb begin
    if(A>B) begin
        A_is_greater = 1'b1;
    end
    else begin
        A_is_greater = 1'b0;
    end
    end
endmodule

module min_select(
    input logic [3:0] A,
    input logic [3:0] B,
    output logic [3:0] min
);
    logic A_is_greater;
    compare4 COMB(.A(A), .B(B), .A_is_greater(A_is_greater));


    always_comb begin
    if(!A_is_greater) begin
        min = A;
    end
    else begin
        min = B;
    end
    end
endmodule