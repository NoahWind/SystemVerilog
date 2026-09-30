module arithmetic_unit (
    input  logic [7:0] x,
    input  logic [7:0] y,
    input  logic [1:0] m, // 00 ADD, 01 SUB, 10 MULTIPLY, 11 UNUSED
    output logic [15:0] z
);

    logic [15:0] add_out;
    logic [15:0] sub_out;
    logic [15:0] mult_out;
    
    assign add_out  = $signed(x) + $signed(y);
    assign sub_out  = $signed(x) - $signed(y);

    assign mult_out = $signed(x) * $signed(y);

    mux4to1 #(.WIDTH(16)) arith_mux (
        .in0(add_out),// m = 00 ADD
        .in1(sub_out),// m = 01 SUB
        .in2(mult_out), // m = 10 MULTIPLY
        .in3(16'b0), // m = 11 UNUSED HELT Onödig??
        .sel(m), //Styrsignal M
        .out(z) // Utgång Z
    );

endmodule