module shift_reg(
    input logic load,
    input logic [3:0] d_in,
    input logic s_in,
    input logic clk,
    input logic rst_n,
    output logic [3:0] q_out,
    output logic parity
);

always_ff @(posedge clk or negedge rst_n)begin
    if (rst_n == 0)begin
        q_out <= 4'b0000;
    end
    else begin
        if (load == 1'b1)begin
            q_out <= d_in;
        end

        if (load == 1'b0)begin
            q_out <= {s_in, q_out[3:1]};
        end

    end
end

assign parity = ^q_out;

endmodule