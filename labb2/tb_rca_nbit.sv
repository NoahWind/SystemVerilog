
module tb_rca_nbit_mux;
    parameter N = 4;

    logic [N-1:0] a;
    logic [N-1:0] b;
    logic cin;
    logic [N-1:0] sum;
    logic cout;

    logic [N:0] expected;

    rca_nbit_mux #(.N(N)) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        for (int c = 0; c < 2; c++) begin
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    a = i[N-1:0];
                    b = j[N-1:0];
                    cin = c[0];
                    #10;
                    expected = a + b + cin;
                    assert ({cout, sum} == expected)
                        else $fatal(1, "FEL! a=%d, b=%d, cin=%b, forvantat={%b, %d}, fick={%b, %d}",
                                   a, b, cin, expected[N], expected[N-1:0], cout, sum);
                end
            end
        end
        $display("ALLA TESTFALL FÖR MUX-RCA GODKÄNDA!");
        $finish;
    end
endmodule