`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 01:56:30
// Design Name: 
// Module Name: function_displayer
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

module function_displayer(
    input CLOCK,
    input app_state,
//    input [`ANBIT:0] an_vol, an_pong,
//    input [`SEGDPBIT:0] seg_vol, seg_pong,
//    input [`OLEDBIT:0] oled_menu, oled_pong, oled_wave, oled_vol, oled_tetris, oled_pass, led_vol,
      input [`OLEDBIT:0] volume_bar_data, alioto_data,
//    output reg [`ANBIT:0] an,
//    output reg [`SEGDPBIT:0] seg,
    output reg [`OLEDBIT:0] my_oled_data //, led
    );
    
    always @ (posedge CLOCK) begin
    case(app_state)
    //VOLUME BAR
    0:
        my_oled_data <= volume_bar_data;
    //ALIOTO
    1:
        my_oled_data <= alioto_data;
    endcase
    
    end
endmodule
