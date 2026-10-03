module parking_counter (
    input  logic clk,
    input  logic rst_n,
    input logic car_in,
    input logic car_out,
    output logic [4:0] cars
);

logic [4:0] limit;
assign limit = 5'b10000;
logic [1:0] state;

always_ff (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cars <= 5'b0;
    end


    case ({car_in, car_out})
    2'b01: begin
        if(cars != 5'b0)begin
            cars<=cars-1;
        end
    end

        2'b10: begin
        if(cars != 5'b10000)begin
            cars<=cars+1;
        end
    end 
    endcase
    end
endmodule