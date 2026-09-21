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
        for (int i = 0; i <= 8'hff; i++) begin
            for (int j = 0; j <= 8'hff; j++) begin
                a = i[7:0]; 
                b = j[7:0]; 
                #100;
		assert ( sum == (j+i)) else $fatal(1, "BAD %d %d", i,j);
            end
        end
        
        $finish;
    end
endmodule
