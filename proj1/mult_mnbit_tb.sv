module tb_mult_mnbit_signed;
    // Signaler deklarerade som signed för tvåkomplement
    logic signed [3:0] a;
    logic signed [3:0] b;
    logic signed [7:0] product;

    // Instansiera signed-multiplikatorn
    mult_mnbit_signed #(
        .M(4),
        .N(4)
    ) uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        // Loopar igenom alla 16 kombinationer för 4-bitars signed (-8 till +7)
        for (int i = -8; i <= 7; i++) begin
            for (int j = -8; j <= 7; j++) begin
                a = i[3:0]; 
                b = j[3:0]; 
                #100;
                
                // Jämför signed-multiplikation
                assert (product == (a * b)) 
                    else $fatal(1, "FEL! a=%d, b=%d, forvantat=%d, fick=%d", a, b, (a * b), product);
            end
        end
        
        $display("ALLA TESTFALL FÖR SIGNED MULTIPLIKATOR GODKÄNDA!");
        $finish;
    end
endmodule