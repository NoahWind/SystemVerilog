module pattern_counter (
    input logic clk,
    input logic din,
    input logic m1,
    input logic m0,
    input logic rst_n,
    output logic [7:0] count
);

logic [2:0] check;
logic [2:0] ans;

assign ans = {1'b1, 1'b0, 1'b1};

always_ff @(posedge clk or negedge rst_n)begin
    if (!rst_n) begin
        check <= 3'b000;
        count <= 8'b0;
    end

    else begin
    
    check <= {check[1:0], din};

    if (2'b00 == {m1, m0}) begin
        count = count;
    end

    if (2'b01 == {m1, m0}) begin
        count <= count + 1;
    end

    if (2'b10 == {m1, m0}) begin
        if (ans == {check[1], check[0], din}) begin
        count <= count + 1;
            
        end
    end

    if (2'b11 == {m1, m0}) begin
        count <= 0;
    end

    end

end

endmodule