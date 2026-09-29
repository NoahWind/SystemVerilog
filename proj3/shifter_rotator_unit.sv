module shifter_rotator_unit (
    input  logic [7:0]  x,
    input  logic [7:0]  y,
    input  logic [1:0]  m, // 00 ROTATE RIGHT, 01 ROTATE LEFT, 10 SHIFT RIGHT, 11 SHIFT LEFT
    output logic [15:0] z
);
    logic [7:0] rot_right_res;
    logic [7:0] rot_left_res;
    logic [7:0] shift_right_res;
    logic [7:0] shift_left_res;
    logic [7:0] mux_out_8bit;

    logic [2:0] shift_amt;
    
    assign shift_amt = y[2:0];
    assign rot_right_res = (x >> shift_amt) | (x << (8 - shift_amt));
    assign rot_left_res = (x << shift_amt) | (x >> (8 - shift_amt));
    assign shift_right_res = x >> shift_amt;
    assign shift_left_res  = x << shift_amt;

    mux4to1 #(.WIDTH(8)) shift_mux (
        .in0(rot_right_res),
        .in1(rot_left_res),
        .in2(shift_right_res),
        .in3(shift_left_res),
        .sel(m),
        .out(mux_out_8bit)
    );
    assign z = {8'b0, mux_out_8bit};

endmodule