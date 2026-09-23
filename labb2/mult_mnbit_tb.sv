module tb_mult_mnbit_signed;
    logic signed [3:0] a;
    logic signed [3:0] b;
    logic signed [7:0] product;

    mult_mnbit_signed #(
        .M(4),
        .N(4)
    ) uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        for (int i = -8; i <= 7; i++) begin
            for (int j = -8; j <= 7; j++) begin
                a = i[3:0]; 
                b = j[3:0]; 
                #100;
                
                assert (product == (a * b)) 
                    else $fatal(1, "FEL! a=%0d, b=%0d, förväntat=%0d, fick=%0d", a, b, (a * b), product);
            end
        end
        
        $display("ALLA TESTFALL FÖR SIGNERAD MULTIPLIKATOR GODKÄNDA!");
        $finish;
    end
endmodule