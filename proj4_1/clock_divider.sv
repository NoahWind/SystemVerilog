module clock_divider (
    input  logic clk,
    input  logic rstn,
    output logic divided_clk
);

    logic [18:0] counter;
    always_ff @(posedge clk or negedge rstn) begin
        
        if (!rstn) begin
            counter     <= 19'd0;
            divided_clk <= 1'b0;
        end

        else begin
            if (counter == 19'd499999) begin // Halv period
                counter <= 19'd0;
                divided_clk <= ~divided_clk;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule