module shifter_subtractor(
    input logic clk,
    input logic rst_n,
    input logic [16:0] parallel_in,
    input logic serial_in,
    input logic [1:0] mode,
    output logic [16:0] q
);

always_ff @(negedge  clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= 17'b0;
    end

    else begin
        case (mode)
        2'b00: q <= 17'b0;
        2'b01: q <= {q[15:0], serial_in};
        2'b10: q <= parallel_in - q;
        2'b11: q <= parallel_in;
        endcase
    end
end

endmodule