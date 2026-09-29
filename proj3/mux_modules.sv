module mux2to1 #(
    parameter WIDTH = 16
)(
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    input  logic             sel,
    output logic [WIDTH-1:0] out
);

    assign out = sel ? in1 : in0;

endmodule

module mux4to1 #(
    parameter WIDTH = 16
)(
    input  logic [WIDTH-1:0] in0,  // = 00
    input  logic [WIDTH-1:0] in1,  // = 01
    input  logic [WIDTH-1:0] in2,  // = 10
    input  logic [WIDTH-1:0] in3,  // = 11
    input  logic [1:0]       sel,  // Styrsignal
    output logic [WIDTH-1:0] out
);

    logic [WIDTH-1:0] stage1_low;
    logic [WIDTH-1:0] stage1_high;

    mux2to1 #(.WIDTH(WIDTH)) mux_low (
        .in0(in0),
        .in1(in1),
        .sel(sel[0]),
        .out(stage1_low)
    );

    mux2to1 #(.WIDTH(WIDTH)) mux_high (
        .in0(in2),
        .in1(in3),
        .sel(sel[0]),
        .out(stage1_high)
    );

    mux2to1 #(.WIDTH(WIDTH)) mux_out (
        .in0(stage1_low),
        .in1(stage1_high),
        .sel(sel[1]),
        .out(out)
    );

endmodule