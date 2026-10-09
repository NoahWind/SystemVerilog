module arithmetic_unit (
    input  logic [7:0] x,
    input  logic [7:0] y,
    input  logic [1:0] m, 
    output logic [15:0] z
);

    logic [15:0] add_out;
    logic [15:0] sub_out;
    logic [15:0] mult_out;
    
    assign add_out  = (x) + (y);
    assign sub_out  = (x) - (y);
    assign mult_out = (x) * (y);

    mux4to1 #(.WIDTH(16)) arith_mux (
        .in0(add_out),
        .in1(sub_out),
        .in2(mult_out),
        .in3(16'b0), 
        .sel(m), 
        .out(z) 
    );

endmodule