`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 14:38:45
// Design Name: 
// Module Name: mini_volume
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


module mini_volume(input CLOCK, input [12:0] my_pix_index, output reg [15:0] mini_volume_data);

wire [6:0] x_coord; //x-coordinate
wire [6:0] y_coord; //y-coordinate
reg [1:0] COUNT;
assign x_coord = my_pix_index % 96;
assign y_coord = my_pix_index / 96;

wire clk;
clock_divider three_hz(CLOCK, 16666666, clk);

always @ (posedge clk) begin
    COUNT <= COUNT + 1;
end

always @ (posedge CLOCK) begin
if (x_coord >= 30 && x_coord <= 66) begin
    case (COUNT)
    2'd0:
    begin
        if (y_coord >= 47 && y_coord <= 52)
            mini_volume_data <= `GREEN;
        else
            mini_volume_data <= `DARK_MODE;
    end
    2'd1:
    begin
    if (y_coord >= 46 && y_coord <= 52)
        mini_volume_data <= `GREEN;
    else if (y_coord >= 36 && y_coord <= 42)
        mini_volume_data <= `YELLOW;
    else
        mini_volume_data <= `DARK_MODE;
    
    end
    2'd2:
    begin
    if (y_coord >= 46 && y_coord <= 52)
        mini_volume_data <= `GREEN;
    else if (y_coord >= 36 && y_coord <= 42)
        mini_volume_data <= `YELLOW;
    else if (y_coord >= 26 && y_coord <= 32)
        mini_volume_data <= `RED;
    else
        mini_volume_data <= `DARK_MODE;
    end
    2'd3:
        mini_volume_data <= `DARK_MODE;
endcase
end 
end

endmodule
