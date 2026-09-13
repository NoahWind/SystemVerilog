
module cla_8bit_tb;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] sum;

    cla_8bit uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        a = 8'h00; b = 8'h00; #50;
        a = 8'h0F; b = 8'h05; #50;
        a = 8'h7F; b = 8'h01; #50;
        a = 8'h80; b = 8'h80; #50;
        a = 8'hAA; b = 8'h55; #50;
        $finish;
    end
endmodule
