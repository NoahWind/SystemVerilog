module up_down_counter (
    input  logic clk,
    input  logic rst_n,
    input  logic enable,
    input  logic up,
    output logic [3:0] count
);

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count <= 4'b0;
    end

    else if (enable) begin
        if((count == 4'b1111) & up) begin
            count <= 4'b0;
        end
        
        else if((count == 4'b0000) & !up) begin
            count <= 4'b1111;
        end

        else if (up)begin
            count <= count + 1;
        end

        else if (!up) begin
            count <= count - 1;
        end

    end

end


endmodule