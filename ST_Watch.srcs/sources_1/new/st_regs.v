`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2018 11:37:00
// Design Name: 
// Module Name: st_regs
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


`define RUNNING 0
`define SPLIT 1
`define STOP 2
`define RESET 3

`define SWATCH 0
`define TIMER 1

module st_regs(
    input en,
    input mode,
    input start_stop,
    input split_reset,
    input milli1_clk,
    input [3:0] Tmilli1,
    input [3:0] Tmilli10,
    input [3:0] Tmilli100,
    input [3:0] Tsec1,
    input [3:0] Tsec10,
    input [3:0] Tmin1,
    input [3:0] Tmin10,
    input [3:0] Thr1,
    output reg [3:0] Bmilli1,
    output reg [3:0] Bmilli10,
    output reg [3:0] Bmilli100,
    output reg [3:0] Bsec1,
    output reg [3:0] Bsec10,
    output reg [3:0] Bmin1,
    output reg [3:0] Bmin10,
    output reg [3:0] Bhr1
    );
        
    reg [3:0] milli1;  
    reg [3:0] milli10; 
    reg [3:0] milli100;
    reg [3:0] sec1; 
    reg [3:0] sec10;   
    reg [3:0] min1;    
    reg [3:0] min10;
    reg [3:0] hr1;  
    
    reg [1:0] state = `RESET;
    reg start_stop_ff = 1'b0;
    reg start_flag = 1'b0;
    reg split_reset_ff = 1'b0;
    reg split_flag = 1'b0;
      
    always @(posedge milli1_clk) begin
        if (!en)
            state <= `RESET;
            
        if (en) begin
            if (start_stop && !start_stop_ff) begin    
                case(state)
                    `RESET, `STOP, `SPLIT: state <= `RUNNING;
                    `RUNNING: state <= `STOP;
                    default:;
                endcase   
            end
            start_stop_ff <= start_stop;
            
            if (split_reset && !split_reset_ff) begin
                case(state)
                    `RESET, `STOP, `SPLIT: state <= `RESET;
                    `RUNNING: begin
                        Bmilli1 <= milli1;
                        Bmilli10 <= milli10; 
                        Bmilli100 <= milli100; 
                        Bsec1 <= sec1;
                        Bsec10 <= sec10;    
                        Bmin1 <= min1;  
                        Bmin10 <= min10;
                        Bhr1 <= hr1;
                        state <= `SPLIT;                 
                        end      
                    default:;
                endcase
            end
            split_reset_ff <= split_reset;
                    
            if(state != `SPLIT) begin
                    Bmilli1 <= milli1;
                    Bmilli10 <= milli10; 
                    Bmilli100 <= milli100; 
                    Bsec1 <= sec1;
                    Bsec10 <= sec10;    
                    Bmin1 <= min1;  
                    Bmin10 <= min10;
                    Bhr1 <= hr1;
            end
        end   
    end    

    always @(posedge milli1_clk) begin
        case (state)
            `RESET:begin
                case (mode) 
                    `TIMER: begin
                        milli1 <= Tmilli1;
                        milli10 <= Tmilli10; 
                        milli100 <= Tmilli100; 
                        sec1 <= Tsec1;
                        sec10 <= Tsec10;    
                        min1 <= Tmin1;  
                        min10 <= Tmin10;
                        hr1 <= Thr1;
                    end
                    
                    `SWATCH: begin
                       milli1 <= 0;
                       milli10 <= 0; 
                       milli100 <= 0; 
                       sec1 <= 0;
                       sec10 <= 0;    
                       min1 <= 0;  
                       min10 <= 0;
                       hr1 <= 0;
                    end
                    
                    default: begin
                       milli1 <= 0;
                       milli10 <= 0; 
                       milli100 <= 0; 
                       sec1 <= 0;
                       sec10 <= 0;    
                       min1 <= 0;  
                       min10 <= 0;
                       hr1 <= 0;
                    end                  
                endcase 
            end
                   
            `STOP:begin
                  milli1 <= milli1;
                  milli10 <= milli10; 
                  milli100 <= milli100; 
                  sec1 <= sec1;
                  sec10 <= sec10;    
                  min1 <= min1;  
                  min10 <= min10;
                  hr1 <= hr1;
                  end
            
            `SPLIT, `RUNNING:begin
                    if (mode == `SWATCH) begin
                        if(milli1 == 9) begin
                            milli1 <= 0;
                            if(milli10 == 9) begin
                                milli10 <= 0;
                                if(milli100 == 9)  begin
                                    milli100 <= 0;
                                    if(sec1 == 9) begin
                                        sec1 <= 0;
                                        if(sec10 == 5) begin
                                            sec10 <= 0;
                                            if(min1 == 9) begin
                                                min1 <= 0;
                                                if(min10 == 5) begin
                                                    min10 <= 0;
                                                    if(hr1 == 9) begin
                                                        milli1 <= 0;
                                                        milli10 <= 0; 
                                                        milli100 <= 0; 
                                                        sec1 <= 0;
                                                        sec10 <= 0;    
                                                        min1 <= 0;  
                                                        min10 <= 0;
                                                        hr1 <= 0;
                                                    end else
                                                        hr1 <= hr1 + 1;    
                                                end else
                                                    min10 <= min10 + 1;
                                            end else
                                                min1 <= min1 + 1;    
                                        end else
                                            sec10 <= sec10 + 1;   
                                    end else
                                        sec1 <= sec1 + 1;    
                                end else
                                    milli100 <= milli100 + 1;   
                            end else
                                milli10 <= milli10 + 1;    
                        end else
                            milli1 <= milli1 + 1; 
                    end
                    
                    else if (mode == `TIMER) begin
                        if(milli1 == 0) begin
                            milli1 <= 0;
                            if(milli10 == 0) begin
                                milli10 <= 9;
                                if(milli100 == 0)  begin
                                    milli100 <= 9;
                                    if(sec1 == 0) begin
                                        sec1 <= 9;
                                        if(sec10 == 0) begin
                                            sec10 <= 5;
                                            if(min1 == 0) begin
                                                min1 <= 9;
                                                if(min10 == 0) begin
                                                    min10 <= 5;
                                                    if(hr1 == 0) begin
                                                        milli1 <= 0;
                                                        milli10 <= 0; 
                                                        milli100 <= 0; 
                                                        sec1 <= 0;
                                                        sec10 <= 0;    
                                                        min1 <= 0;  
                                                        min10 <= 0;
                                                        hr1 <= 0;
                                                    end else
                                                        hr1 <= hr1 - 1;    
                                                end else
                                                    min10 <= min10 - 1;
                                            end else
                                                min1 <= min1 - 1;    
                                        end else
                                            sec10 <= sec10 - 1;   
                                    end else
                                        sec1 <= sec1 - 1;    
                                end else
                                    milli100 <= milli100 - 1;   
                            end else
                                milli10 <= milli10 - 1;    
                        end else
                            milli1 <= milli1 - 1; 
                    end
                end                                      
            default:;
        endcase
    end            
endmodule

