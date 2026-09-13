module cla_8bit_sat_out_tb;
    logic [7:0] a;
    logic [7:0] b;
    logic [7:0] sum;
    logic ovf;
    logic uvf;

    cla_8bit_sat_out uut (
        .a(a),
        .b(b),
        .sum(sum),
        .ovf(ovf),
        .uvf(uvf)
    );

    initial begin
        $monitor("Time=%0t | a=%h b=%h | sum=%h | ovf=%b uvf=%b", $time, a, b, sum, ovf, uvf);
        a = 8'h00; b = 8'h00; #100;
        a = 8'h10; b = 8'h20; #100;
        a = 8'h7F; b = 8'h01; #100; // Overflow -> sum ska bli 7F
        a = 8'h7F; b = 8'h7F; #100; // Overflow -> sum ska bli 7F 
        a = 8'h80; b = 8'h80; #100; // Underflow -> sum ska bli 80
        a = 8'h80; b = 8'h01; #100; // Normal
        $finish;
    end
endmodule