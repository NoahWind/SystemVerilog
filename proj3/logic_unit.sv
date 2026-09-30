module logic_unit (
    input  logic [7:0] x,
    input  logic [7:0] y,
    input  logic [1:0] m,// 00 AND, 01 OR, 10 NOT, 11 XOR
    output logic [15:0] z
);

    logic [7:0] and_res;
    logic [7:0] or_res;
    logic [7:0] not_res;
    logic [7:0] xor_res;
    logic [7:0] mux_out_8bit;

    assign and_res = x & y;
    assign or_res = x | y;
    assign not_res = ~x;
    assign xor_res = x ^ y;

    mux4to1 #(.WIDTH(8)) logic_mux (
        .in0(and_res),
        .in1(or_res),
        .in2(not_res),
        .in3(xor_res),
        .sel(m), //Styrsignal M
        .out(mux_out_8bit)
    );
    assign z = {8'b0, mux_out_8bit};

endmodule