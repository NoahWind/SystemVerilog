module priority_encoder (
    input  logic [3:0] request,
    output logic [1:0] code,
    output logic valid
);

always_comb begin
    code = 2'b00;
    valid = 0;
    if (request[3]) begin
        code = 2'b11;
            valid = 1;
        end
    else if (request[2]) begin
        code = 2'b10;
            valid = 1;
    end
    else if (request[1]) begin
        code = 2'b01;
            valid = 1;
    end
    else if (request[0]) begin
        code = 2'b00;
            valid = 1;
    end
    else begin
        valid = 0;
    end
end

endmodule