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

    initial begin
        // Slumpmässiga
        for (int i = 0; i < 100:00; i++) begin
            a0 = $urandom_range(0, 15);
            a1 = $urandom_range(0, 15);
            a2 = $urandom_range(0, 15);
            a3 = $urandom_range(0, 15);
            a4 = $urandom_range(0, 15);
            a5 = $urandom_range(0, 15);
            a6 = $urandom_range(0, 15);
            a7 = $urandom_range(0, 15);
            #100;
            expected_x = (a0 * a1) + (a2 * a3) + (a4 * a5) + (a6 * a7);
            assert (x == expected_x) else $fatal(1, "FEL! förväntat=%0d, fick=%0d", expected_x, x);
        end

        $display("ALLA TESTFALL FÖR MULTIADD k!");
        $finish;
    end

endmodule