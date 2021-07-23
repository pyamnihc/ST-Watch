`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2018 17:41:42
// Design Name: 
// Module Name: clk_src
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
`define MILLI_CNT 50000
`define REF_CNT 6250

module clk_src(
    input en,
    input clk100MHz,
    output reg milli1_clk,
    output reg refresh_clk
    );
    
    reg [15:0] milli1 = 0;
    reg [12:0] refresh = 0;
    
    initial milli1_clk = 1'b0;
    initial refresh_clk = 1'b0;
    
    always @(posedge clk100MHz) begin
        if (!en) begin
            milli1 <= 0;
            refresh <= 0;
            milli1_clk <= 1'b0;
            refresh_clk <= 1'b0;
        end
                
        if (en) begin
            if (milli1 < `MILLI_CNT) begin
                milli1 <= milli1 + 1;
            end
        
            else begin
                milli1_clk <= ~milli1_clk;
                milli1 <= 0;
            end

            if (refresh < `REF_CNT) begin
                refresh <= refresh + 1;
            end
            
            else begin
                refresh_clk <= ~refresh_clk;
                refresh <= 0;
            end
        end                       
    end
endmodule