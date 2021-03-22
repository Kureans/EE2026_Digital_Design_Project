`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 14:38:05
// Design Name: 
// Module Name: clock_simul
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


module clock_simul();

    reg basys_clock;
    wire new_clock;
    
    clock_divider my_20khz_clk (basys_clock, 2499, new_clock);
    
    always begin
        #5 basys_clock <= ~basys_clock; 
    end
    
    initial begin
        basys_clock = 0;
    end

endmodule
