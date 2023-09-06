`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 04:29:36 PM
// Design Name: 
// Module Name: top_module
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

module hex7seg(
    output logic [6:0]sseg,
    output logic [7:0]an,
    input logic en,
    input logic sel,
    input logic rst,
    input clk
);
    assign an = 8'b11111111;
    
    typedef enum logic [2:0]{
    S0, S1, S2, S3, S4, S5, S6, S7
    }count_states;
    
    logic [2:0] state, next_state;
    logic [7:0]an_data;
    logic [6:0]sseg_data;
    
    always @(posedge clk)
        if(rst)
            state <= S0;
        else begin
            case (state)
                S0: 
                    begin
                        an_data <= 8'b00000001;
                        sseg_data <= 7'b1100011;                
                        next_state <= en ? S0 : sel ? S7 : S0;
                        #5;
                    end
                    
                S1: 
                    begin
                        an_data <= 8'b00000001;
                        sseg_data <= 7'b1011100;
                        next_state <= en ? S1 : sel ? S0 : S1;
                        #5;
                    end
                    
                S2: 
                    begin
                        an_data <= 8'b00000010;
                        sseg_data <= 7'b1100011;
                        next_state <= en ? S2 : sel ? S1 : S2;
                        #5;
                    end
                S3: 
                    begin
                        an_data <= 8'b00000010;
                        sseg_data <= 7'b1011100;
                        next_state <= en ? S3 : sel ? S2 : S3;
                        #5;
                    end
                S4: 
                    begin
                        an_data <= 8'b00000100;
                        sseg_data <= 7'b1100011;
                        next_state <= en ? S4 : sel ? S3 : S4;
                        #5;
                    end
                S5: 
                    begin
                        an_data <= 8'b00000100;
                        sseg_data <= 7'b1011100;
                        next_state <= en ? S5 : sel ? S4 : S5;
                        #5;
                    end
                S6:
                    begin
                        an_data <= 8'b00001000;
                        sseg_data <= 7'b1100011; 
                        next_state <= en ? S6 : sel ? S5 : S6;
                        #5;
                    end
                    
                S7: 
                    begin
                        an_data <= 8'b00001000;
                        sseg_data <= 7'b1011100;
                        next_state <= en ? S7 : sel ? S6 : S7;
                        #5;
                    end
                    
                default: 
                    begin
                        an_data <= 8'b00000001;
                        sseg <= 7'b1100011;
                        next_state <= S0;
                    end
            endcase
        end
    assign an = an_data;
    assign sseg = sseg_data;    
    //assign state = next_state;

endmodule
