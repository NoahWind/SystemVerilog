
module mux41 (
    input  logic d0,
    input  logic d1,
    input  logic d2,
    input  logic d3,
    input  logic [1:0] s,
    output logic y
);
    assign y = (s == 2'b00) ? d0 :
               (s == 2'b01) ? d1 :
               (s == 2'b10) ? d2 : d3;
endmodule

module shifter_rotator (
    input  logic [3:0] x,
    input  logic [1:0] select,
    output logic [3:0] y
);

    mux41 m0 ( // either value to left or right or 1 or 0
        .d0(1'b0),
        .d1(x[1]),
        .d2(x[3]),
        .d3(x[1]),
        .s(select),
        .y(y[0])
    );

    mux41 m1 ( // either value to left or right
        .d0(x[0]),
        .d1(x[2]),
        .d2(x[0]),
        .d3(x[2]),
        .s(select),
        .y(y[1])
    );

    mux41 m2 ( // either value to left or right
        .d0(x[1]),
        .d1(x[3]),
        .d2(x[1]),
        .d3(x[3]),
        .s(select),
        .y(y[2])
    );

    mux41 m3 ( // either value to left or right or 1 or 0
        .d0(x[2]),
        .d1(1'b0),
        .d2(x[2]),
        .d3(x[0]),
        .s(select),
        .y(y[3])
    );

endmodule