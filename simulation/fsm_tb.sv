`timescale 1ns/1ns

module fsm_tb;
    reg clk_i; reg rst_i; reg x_i;
    wire y_o;

fsm DUT (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .x_i(x_i),
    .y_o(y_o)
);

initial begin
    forever begin
        #5; 
        clk_i = ~clk_i;
    end
end


task random_sequence(); 
begin 
    repeat(80)   
    begin
        x_i = $random(); // {$random} % 0 or 1
        #10;    
    end
end
endtask

task reset(); 
begin 
    rst_i = 0;
    #10;    
    rst_i = 1;
end
endtask


initial 
begin 
clk_i = 0; rst_i = 1;
random_sequence();
reset();
random_sequence();

$finish;
end
endmodule
