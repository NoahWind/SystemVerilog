module fpga_top (
    input  logic [11:0] SW,   // SW[3:0]=X, SW[7:4]=Y, SW[9:8]=M, SW[11:10]=S
    output logic [15:0] LEDR  // LEDR[3:0]=X, LEDR[7:4]=Y, LEDR[15:8]=Z
);

    logic [3:0] x;
    logic [3:0] y;
    logic [1:0] m;
    logic [1:0] s;
    logic [7:0] z;

    assign x = SW[3:0];
    assign y = SW[7:4];
    assign m = SW[9:8];
    assign s = SW[11:10];

    alu_4bit u_alu_4bit (
        .x(x),
        .y(y),
        .m(m),
        .s(s),
        .z(z)
    );

    assign LEDR[3:0]  = x;
    assign LEDR[7:4]  = y;
    assign LEDR[15:8] = z;

endmodule