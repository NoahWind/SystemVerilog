module alu (
    input  logic [7:0]  x,
    input  logic [7:0]  y,
    input  logic [1:0]  m,
    input  logic [1:0]  s,
    output logic [15:0] z
);

    logic [15:0] z_arith;
    logic [15:0] z_shift;
    logic [15:0] z_comp;
    logic [15:0] z_logic;

    arithmetic_unit u_arith (
        .x(x),
        .y(y),
        .m(m),
        .z(z_arith)
    );

    shifter_rotator_unit u_shift (
        .x(x),
        .y(y),
        .m(m),
        .z(z_shift)
    );

    comparator_unit u_comp (
        .x(x),
        .y(y),
        .m(m),
        .z(z_comp)
    );

    logic_unit u_logic (
        .x(x),
        .y(y),
        .m(m),
        .z(z_logic)
    );

    mux4to1 #(.WIDTH(16)) top_alu_mux (
        .in0(z_arith),// s = 00 Arithmetic
        .in1(z_shift), // s = 01 Shift/Rotate
        .in2(z_comp), // s = 10 Compare
        .in3(z_logic), // s = 11 Logic
        .sel(s), // Styrsignal S
        .out(z) // ALU-utgång Z
    );

endmodule