module tb_mult_mnbit;
    logic [3:0] a;
    logic [3:0] b;
    logic [7:0] product;

    mult_mnbit #(
        .M(4),
        .N(4)
    ) uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        for (int i = 0; i <= 15; i++) begin
            for (int j = 0; j <= 15; j++) begin
                a = i[3:0]; 
                b = j[3:0]; 
                #100;
                
                assert (product == (a * b)) 
                    else $fatal(1, "FEL! a=%d, b=%d, forvantat=%d, fick=%d", a, b, (a * b), product);
            end
        end
        
        $display("ALLA TESTFALL F�R UNSIGNED MULTIPLIKATOR GODK�NDA!");
        $finish;
    end
endmodule