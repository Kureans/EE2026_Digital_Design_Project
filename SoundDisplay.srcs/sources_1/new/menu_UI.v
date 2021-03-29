`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 09:07:29
// Design Name: 
// Module Name: menu_UI
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
`include "constants.vh"

module menu_UI(input [12:0] my_pix_index, input CLOCK, input BTNU, reset,// BTNL, BTNR, BTND, BTNU, 
output reg [15:0] menu_data, output reg app_state = 0);

wire [6:0] x_coord; //x-coordinate
wire [6:0] y_coord; //y-coordinate
wire clk;
reg [15:0] mini_volume_data, blank_data;

wire sixp25clk;
reg item = 0;
reg [1:0] COUNT;


assign x_coord = my_pix_index % 96;
assign y_coord = my_pix_index / 96;

clock_divider three_hz(CLOCK, 16666666, clk);
//CLOCK FOR APP STATE
always @ (posedge CLOCK) begin
if (BTNU == 1)
    app_state <= app_state + 4;
if (reset == 1)
        app_state <= 0;
end


always @ (posedge clk) begin
    COUNT <= COUNT + 1;
end


wire [10:0] x_cir2;
wire [10:0] y_cir2;
parameter [10:0] r1_sq = 11'd784;
parameter [6:0] x_centre = 7'd48;
parameter [6:0] y_centre = 7'd32;

assign x_cir2 = (x_coord  - x_centre)*(x_coord  - x_centre);
assign y_cir2 = (y_coord  - y_centre)*(y_coord  - y_centre);

always @ (posedge CLOCK) begin

//CIRCLE SKY BACKGROUND:
if (x_cir2 + y_cir2 <= r1_sq)
    mini_volume_data = `CYAN;
else
    mini_volume_data = `WHITE;

//VOLUME BAR DISP
if (x_coord >= 28 && x_coord <= 68 && y_coord >= 12 && y_coord <= 52) begin 
    if (x_coord >= 34 && x_coord <= 62) begin
    case (COUNT)
    2'd0:
    begin
        if (y_coord >= 43 && y_coord <= 48)
            mini_volume_data <= `GREEN;
        else
            mini_volume_data <= `DARK_MODE;
    end
    2'd1:
    begin
    if (y_coord >= 43 && y_coord <= 48)
        mini_volume_data <= `GREEN;
    else if (y_coord >= 34 && y_coord <= 39)
        mini_volume_data <= `YELLOW;
    else
        mini_volume_data <= `DARK_MODE;
    
    end
    2'd2:
    begin
    if (y_coord >= 43 && y_coord <= 48)
        mini_volume_data <= `GREEN;
    else if (y_coord >= 34 && y_coord <= 39)
        mini_volume_data <= `YELLOW;
    else if (y_coord >= 25 && y_coord <= 30)
        mini_volume_data <= `RED;
    else
        mini_volume_data <= `DARK_MODE;
    end
    2'd3:
        mini_volume_data <= `DARK_MODE;
endcase
    end 
    else
        mini_volume_data <= `DARK_MODE;
    end

    

    
//ARROWS
    case (x_coord)
    7'd19:
        if (y_coord == 32)
                mini_volume_data <= `GREY;
    7'd20:
        if (y_coord >= 31 && y_coord <= 33)
                mini_volume_data <= `GREY;
    7'd21: 
        if (y_coord == 30 || y_coord == 31 || y_coord == 33 || y_coord == 34)
            mini_volume_data <= `GREY;    
    7'd22:
        if (y_coord == 29 || y_coord == 30 || y_coord == 34 || y_coord == 35)
            mini_volume_data <= `GREY;
    7'd23:
        if (y_coord == 28 || y_coord == 29 || y_coord == 35 || y_coord == 36)
            mini_volume_data <= `GREY;
    7'd24:
        if (y_coord == 27 || y_coord == 28 || y_coord == 36 || y_coord == 37)
            mini_volume_data <= `GREY;

                  
    7'd72: 
        if (y_coord == 27 || y_coord == 28 || y_coord == 36 || y_coord == 37)
            mini_volume_data <= `GREY;    
    7'd73:
        if (y_coord == 28 || y_coord == 29 || y_coord == 35 || y_coord == 36)
            mini_volume_data <= `GREY;
    7'd74:
        if (y_coord == 29 || y_coord == 30 || y_coord == 34 || y_coord == 35)
            mini_volume_data <= `GREY;
    7'd75:
        if (y_coord == 30 || y_coord == 31 || y_coord == 33 || y_coord == 34)
            mini_volume_data <= `GREY;
    7'd76:
        if (y_coord >= 31 && y_coord <= 33)
            mini_volume_data <= `GREY;
    7'd77:
         if (y_coord == 32)
            mini_volume_data <= `GREY;
    endcase
    
    //SIDE DISPLAYS:
    if (x_coord <= 8) begin
        if (y_coord >= 12 && y_coord <= 20) begin
            if (x_coord >= 8 - (y_coord - 12)) //top left triangle
                mini_volume_data <= `DARK_MODE;
            end
        else if (y_coord >= 44 && y_coord <= 52) begin //bottom right triangle
            if (y_coord - 44 <= x_coord)
                mini_volume_data <= `DARK_MODE;
            end
        else if (y_coord >= 21 && y_coord <= 43)
            mini_volume_data <= `DARK_MODE;
        end            
        
     if (x_coord >= 87) begin
         if (y_coord >= 12 && y_coord <= 20) begin
                    if (y_coord - 12 >= x_coord - 87) //top right triangle
                        mini_volume_data <= `DARK_MODE;
                    end
                else if (y_coord >= 44 && y_coord <= 52) begin //bottom right triangle
                    if (8 - (y_coord - 44) >= x_coord - 87)
                        mini_volume_data <= `DARK_MODE;
                    end
                else if (y_coord >= 21 && y_coord <= 43)
                    mini_volume_data <= `DARK_MODE;
                end    
                
    //WORD: HOME
    if (x_coord == 39 || x_coord == 42 || x_coord == 49 || x_coord == 53 || x_coord == 55) begin
        if (y_coord >= 5 && y_coord <= 9) 
            mini_volume_data <= `MAROON;
    end
    
    if (x_coord >= 40 && x_coord <= 41) begin
        if (y_coord == 7)
            mini_volume_data <= `MAROON;
    end   
    if (x_coord == 44 || x_coord == 47) begin
        if (y_coord >= 6 && y_coord <= 8)
            mini_volume_data <= `MAROON;        
    end
    
    if (y_coord == 5 || y_coord == 9) begin
        if (x_coord == 45 || x_coord == 46 || (x_coord >= 55 && x_coord <= 59))
            mini_volume_data <= `MAROON;
    end
    
    if (x_coord == 50 || x_coord == 52) begin
        if (y_coord == 6)
            mini_volume_data <= `MAROON;
    end
    
    if (x_coord == 51 && y_coord == 7)
        mini_volume_data <= `MAROON;
    
    if (y_coord == 7) begin
        if (x_coord >= 56 && x_coord <= 58)
            mini_volume_data <= `MAROON;
    end
        
    
     
    
      
end


always @ (posedge CLOCK) begin
    menu_data <= mini_volume_data;
end
endmodule

