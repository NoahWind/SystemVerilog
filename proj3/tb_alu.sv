`timescale 1ns / 1ps

module tb_alu;

    logic [7:0]  x;
    logic [7:0]  y;
    logic [1:0]  m;
    logic [1:0]  s;
    logic [15:0] z;

    logic [15:0] expected_z;
    int test_count = 0;

    alu dut (.x(x),.y(y),.m(m),.s(s),.z(z));

    function automatic logic [15:0] get_expected(
        input logic [7:0] in_x,
        input logic [7:0] in_y,
        input logic [1:0] in_s,
        input logic [1:0] in_m
    );
        logic [2:0] shift_amt;
        shift_amt = in_y[2:0];

        case (in_s)
            2'b00: begin
                case (in_m)
                    2'b00: return (in_x) + (in_y);
                    2'b01: return (in_x) - (in_y);
                    2'b10: return (in_x) * (in_y);// MULTIPLY
                    2'b11: return 16'h0000;
                endcase
            end

            2'b01: begin
                case (in_m)
                    2'b00: return {8'b0, (in_x >> shift_amt) | (in_x << (8 - shift_amt))};
                    2'b01: return {8'b0, (in_x << shift_amt) | (in_x >> (8 - shift_amt))};
                    2'b10: return {8'b0, in_x >> shift_amt};
                    2'b11: return {8'b0, in_x << shift_amt};
                endcase
            end

            // 3. COMPARE (S = 10)
            2'b10: begin
                case (in_m)
                    2'b00: return {15'b0, (in_x > in_y)};
                    2'b01: return {15'b0, (in_x < in_y)};
                    2'b10: return {15'b0, (in_x == in_y)};
                    2'b11: return {15'b0, (in_x != in_y)};
                endcase
            end

            // 4. LOGIC (S = 11)
            2'b11: begin
                case (in_m)
                    2'b00: return {8'b0, in_x & in_y};
                    2'b01: return {8'b0, in_x | in_y}; 
                    2'b10: return {8'b0, ~in_x};
                    2'b11: return {8'b0, in_x ^ in_y};
                endcase
            end
        endcase
    endfunction

    initial begin
        for (int sel_s = 0; sel_s < 4; sel_s++) begin
            for (int sel_m = 0; sel_m < 4; sel_m++) begin
                
                repeat (20) begin
                    x = $urandom();
                    y = $urandom();
                    s = sel_s[1:0];
                    m = sel_m[1:0];
                    expected_z = get_expected(x, y, s, m);
                    #10;

                    test_count++;
                    assert (z == expected_z)
                    else $fatal(1, "FEL! S=%b, M=%b, x=%0d, y=%0d, excp=%0d, fick=%0d", 
                                s, m, x, y, expected_z, z);
                    
                end
            end
        end
        $finish;
    end

endmodule