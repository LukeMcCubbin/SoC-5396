`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 12:02:31 PM
// Design Name: 
// Module Name: down_counter
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


module down_counter(
    input clk,
    input enable,
    input [3:0] randNum,
    output [3:0] downout
    );
    
    always @(posedge clk)
    begin
        if(enable)
            downout <= downout - 1'b1;
        else
            downout <= randNum;
    end
    
endmodule
