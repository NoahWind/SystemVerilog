module tb_mult_add;

    logic [3:0] a0, a1, a2, a3, a4, a5, a6, a7;
    logic [9:0] x;
    logic [9:0] expected_x;

    mult_add uut (
        .a0(a0), .a1(a1),
        .a2(a2), .a3(a3),
        .a4(a4), .a5(a5),
        .a6(a6), .a7(a7),
        .x(x)
    );

    task check_result();
        #10;
        expected_x = (a0 * a1) + (a2 * a3) + (a4 * a5) + (a6 * a7);
        assert (x == expected_x) 
            else $fatal(1, "FEL! expected=%0d, got=%0d", expected_x, x);
    endtask

    initial begin
        // 1. Hörnhall / Gränsvärden (Corner cases)
        a0=0;  a1=0;  a2=0;  a3=0;  a4=0;  a5=0;  a6=0;  a7=0;  check_result();
        a0=15; a1=15; a2=15; a3=15; a4=15; a5=15; a6=15; a7=15; check_result();
        a0=15; a1=0;  a2=15; a3=0;  a4=15; a5=0;  a6=15; a7=0;  check_result();

        // 2. Stega igenom alla 256 kombinationer för varje enskilt par (övriga = 0)
        a0=0; a1=0; a2=0; a3=0; a4=0; a5=0; a6=0; a7=0;
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                a0 = i; a1 = j; check_result(); // Testar m0
                a2 = i; a3 = j; check_result(); // Testar m1
                a4 = i; a5 = j; check_result(); // Testar m2
                a6 = i; a7 = j; check_result(); // Testar m3
            end
        end

        // 3. Slumpmässigt urval av 10 000 kombinationer för hela trädet
        for (int i = 0; i < 10000; i++) begin
            a0 = $urandom_range(0, 15);
            a1 = $urandom_range(0, 15);
            a2 = $urandom_range(0, 15);
            a3 = $urandom_range(0, 15);
            a4 = $urandom_range(0, 15);
            a5 = $urandom_range(0, 15);
            a6 = $urandom_range(0, 15);
            a7 = $urandom_range(0, 15);
            check_result();
        end

        $display("EFFEKTIV TESTBÄNK GODKÄND (Gränsvärden + Parvis + 10k Slumpmässiga tester)!");
        $finish;
    end

endmodule