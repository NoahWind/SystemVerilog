module tb_security_alarm;
    logic door;
    logic window;
    logic armed;
    logic alarm;

    security_alarm uut(
        .door(door), .window(window), .armed(armed), .alarm(alarm)
    );
    initial begin
    for (int i = 0; i!= 2; i++) begin
        for (int j = 0; j!= 2; j++)begin
            for(int p = 0; p!= 2; p++) begin
                door = i;
                window = j;
                armed = p;
                #10;
            end
        end
    end
    $finish;
    
    end 



endmodule