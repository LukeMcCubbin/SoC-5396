`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2023 02:55:37 PM
// Design Name: 
// Module Name: mux
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


module mux#(parameter N=4)(
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic [N-1:0] c,
    input logic [N-1:0] d,
    input logic [N-1:0] sel,
    output logic [N-1:0] e
    );
    
    parameter [1:0] A=2'b00;
    parameter [1:0] B=2'b01;
    parameter [1:0] C=2'b10;
    parameter [1:0] D=2'b11;
    
    always_comb
    
        case(sel)
        A: e=a;
        B: e=b;
        C: e=c;
        D: e=d;
        default: e=4'bzzzz;
      endcase
        
    
endmodule



