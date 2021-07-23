`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2018 18:18:10
// Design Name: 
// Module Name: ssd_8_driver
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


module ssd_8_driver(
    input en,
    input refresh_clk,
    input [55:0] data,
    output reg dp,
    output reg [6:0] segs,
    output reg [7:0] an
    );
    
    reg [2:0] index = 0;
    initial dp = 1'b1;
    initial segs = 7'b1111111;
    initial an = 8'b01111111;
    
    always @(posedge refresh_clk) begin
        if (!en) begin
            index <= 0;
            dp = 1'b1;
            an = 8'b01111111;
            segs = 7'b1111111;
        end
        
        if (en) begin
            segs <= data[7*index+:7];
            an <= {an[6:0], an[7]};
            index <= index + 1;
            if (index > 7)
                index <= 0; 
            case(an)
                8'b11111011, 8'b11101111, 8'b10111111: dp <= 0;
                default dp <= 1;
            endcase
        end
    end
    
endmodule