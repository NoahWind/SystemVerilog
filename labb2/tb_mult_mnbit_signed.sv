
module tb_mult_mnbit_signed;
    parameter M = 4;
    parameter N = 4;

    logic signed [M-1:0] a;
    logic signed [N-1:0] b;
    logic signed [M+N-1:0] product;
    logic signed [M+N-1:0] expected_product;

    mult_mnbit_signed #(.M(M), .N(N)) uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        for (int i = -8; i <= 7; i++) begin
            for (int j = -8; j <= 7; j++) begin
                a = i[M-1:0];
                b = j[N-1:0];
                #10;
                expected_product = a * b;
                assert (product == expected_product)
                    else $fatal(1, "FEL! a=%d, b=%d, forvantat=%d, fick=%d", a, b, expected_product, product);
            end
        end
        $display("ALLA TESTFALL FÖR SIGNERAD MULTIPLIKATOR GODKÄNDA!");
        $finish;
    end
endmodule