
module tb_shifter_rotator;

    logic [3:0] x;
    logic [1:0] select;
    logic [3:0] y;
    logic [3:0] expected_y;

    shifter_rotator uut (
        .x(x),
        .select(select),
        .y(y)
    );

    initial begin
        for (int sel = 0; sel < 4; sel++) begin
            for (int val = 0; val < 16; val++) begin
                x = val[3:0];
                select = sel[1:0];

                #10;

                case (select)
                    2'b00: expected_y = {x[2:0], 1'b0};
                    2'b01: expected_y = {1'b0, x[3:1]};
                    2'b10: expected_y = {x[2:0], x[3]};
                    2'b11: expected_y = {x[0], x[3:1]};
                endcase

                assert (y == expected_y)
                    else $fatal(1, "FEL! select=%b, x=%b, expected=%b, got=%b", select, x, expected_y, y);
            end
        end

        $display("ALLA TESTFALL FÖR SHIFTER_ROTATOR GODKÄNDA!");
        $finish;
    end

endmodule