`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 11:34:34 AM
// Design Name: 
// Module Name: ms_counter
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


module ms_counter(
    input clk,
    input rst,
    input start,
    input btnS,
    output ready,
    output done,
    output [9:0] ms
    );
    
    localparam CLK_MS_COUNT = 100000; //1ms tick
    typedef enum {idle, waite, count, done} state_type;
    
    state_type state_reg, state_next;
    logic [16:0] t_reg, t_next;
    logic [9:0] p_reg, p_next;
    logic delay_reg;
    logic edg;
    
    //FSMD state & data reg
    always_ff @(posedge clk, posedge rst)
        if (reset)
            begin
                state_reg <= idle;
                t_reg <= 0;
                p_reg_reg <= 0;
                delay_reg <= 0;
            end
        else
            begin
                state_reg <= state_next;
                t_reg <= t_next;
                p_reg <= p_next;
                
              delay_reg <= btnS;
            end
        assign edg = ~delay_reg & btnS;
        
        always_comb 
        begin
            state_next = state_reg;
            ready = 1'b0;
            done_tick = 1'b0;
            p_next = p_reg;
            t_next = t_reg;
            
            case (state_reg)
                idle:
                    begin
                        ready = 1'b1;
                        if (start)
                            state_next = waite;
                    end 
                waite:
                    if(edg)
                        begin
                            state_next = count;
                            t_next = 0;
                            p_next = 0;
                        end 
                count:
                    if (edg) //2nd edg 
                        state_next = done;
                    else
                        if (t_reg == CLK_MS_COUNT -1) //1ms tick 
                            begin
                                t_next = 0;
                                p_next = p_reg +1;
                            end 
                        else
                            t_next = t_reg +1;
                            
                done:
                    begin
                        done_tick = 1'b1;
                        state_next = idle;
                    end 
                default : state_next = idle;
            endcase
        end
        
        //output
        assign prd = p_reg;

    
endmodule
