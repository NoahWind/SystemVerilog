module fpga_top ( // Test kode for FPGA, use physical inputs/outputs
    input  logic [11:0] SW,
    output logic [15:0] LED 
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
    assign LED[3:0]  = x;
    assign LED[7:4]  = y;
    assign LED[15:8] = z;

endmodule