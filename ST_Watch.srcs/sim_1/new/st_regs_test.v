`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2018 22:47:00
// Design Name: 
// Module Name: st_regs_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module st_regs_test();
reg clk = 1'b0;
reg en;
reg mode;
reg start_stop = 1'b0;

st_regs uut_st_regs(
    .en(en),
    .mode(mode),
    .start_stop(start_stop),
    .milli1_clk(clk)
    );

initial begin
       forever #1 clk = ~clk;
end
initial begin
    #4 en <= 1;
       mode <= 0;
    #4 assign start_stop = 1;
    #2 assign start_stop = 0;
   
end
endmodule
