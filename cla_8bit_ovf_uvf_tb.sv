
module cla_8bit_ovf_uvf_tb;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] sum;
    logic ovf;
    logic uvf;

    cla_8bit_ovf_uvf uut (
        .a(a),
        .b(b),
        .sum(sum),
        .ovf(ovf),
        .uvf(uvf)
    );

    initial begin
        a = 8'h00; b = 8'h00; #100;
        a = 8'h7F; b = 8'h01; #100;
        a = 8'h7F; b = 8'h7F; #100;
        a = 8'h80; b = 8'h80; #100;
        a = 8'h80; b = 8'h01; #100;
        $finish;
    end
endmodule