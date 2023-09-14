`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 03:08:38 PM
// Design Name: 
// Module Name: mux2
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


module mux2#(parameter N=4)(
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic [N-1:0] sel,
    output logic [N-1:0] e
    );
    
    parameter [1:0] A=1'b0;
    parameter [1:0] B=1'b1;
    
    always_comb
    
        case(sel)
        A: e=a;
        B: e=b;
        
        default: e=2'bzzzz;
      endcase
        
    
endmodule
