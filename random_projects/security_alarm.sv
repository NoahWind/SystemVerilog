module security_alarm (
    input  logic door,
    input  logic window,
    input  logic armed,
    output logic alarm
);

always_comb begin
    if (!armed) begin
        alarm = 1'b0;
    end
    else begin
        if(door | window) begin
            alarm = 1'b1;
        end
        else begin
            alarm = 1'b0;
        end
    end
end

endmodule