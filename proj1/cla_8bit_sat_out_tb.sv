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
        for (int i = 0; i <= 8'hff; i++) begin
            for (int j = 0; j <= 8'hff; j++) begin
                a = i[7:0]; 
                b = j[7:0]; 
                #100;
            end
        end
        
        $finish;
    end
endmodule