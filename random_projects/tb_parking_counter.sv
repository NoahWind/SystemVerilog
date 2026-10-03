module tb_parking_counter;
    logic clk;
    logic rst_n;
    logic car_in;
    logic car_out;
    logic [4:0] cars;

    parking_counter uut (.clk(clk), .rst_n(rst_n), .car_in(car_in), .car_out(car_out), .cars(cars));

initial begin
    clk = 0;
    forever #5 clk = ~clk;   

end

initial begin
    rst_n  = 0;
    car_in = 0;
    car_out = 0;
    #10;
    rst_n = 1;

    car_in = 1'b0;
    #40;
    car_in = 1'b1;
    #30;
    car_in = 1'b0;
    #10;
    car_out = 1'b0;
    #10;
    car_in = 1'b1;
    #200;    
    $finish;
end

endmodule