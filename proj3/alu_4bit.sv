module alu_4bit (
    input  logic [3:0]  x,
    input  logic [3:0]  y,
    input  logic [1:0]  m,
    input  logic [1:0]  s,
    output logic [7:0]  z
);

    logic [7:0]  x_8bit;
    logic [7:0]  y_8bit;
    logic [15:0] z_16bit;

    assign x_8bit = {4'b0, x};
    assign y_8bit = {4'b0, y};

    alu top_alu (
        .x(x_8bit),
        .y(y_8bit),
        .m(m),
        .s(s),
        .z(z_16bit)
    );

    assign z = z_16bit[7:0];

endmodule