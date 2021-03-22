`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 14:31:01
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(input CLOCK, input [31:0] my_m_value, output reg new_clock=0);

    reg [31:0] count = 0;

    always @ (posedge CLOCK) begin
        count <= (count == my_m_value)? 0 : count + 1;
        new_clock <= (count == 0) ? ~new_clock : new_clock ;
    end

endmodule
