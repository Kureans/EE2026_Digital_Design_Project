`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 12:25:34
// Design Name: 
// Module Name: task_2a
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


module task_2a(
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    
    input CLOCK, input sw0, sw1,
    output [11:0] mic_in_oled,
    
    output reg [3:0] an_reg = 0,
    output reg [6:0] seg_reg = 0,
    output reg [15:0] led_reg = 0,
    output reg [15:0] led_reg_peak_display = 0,
    
    output reg [3:0] peak_volume_display = 0 //0-15 levels

    );
    
   reg [15:0] led_reg_peak = 0;
   
   reg [3:0] peak_volume = 0; //0-15 levels
   reg [11:0] peak_volume_sample_count = 0; ///4000 samples
   
   reg [1:0] lmh_switcher = 0; //low medium high
   reg anode_switcher = 0; 
   
   wire clk_20k;
   wire clk_5;
   
   wire [11:0] mic_in;
   assign mic_in_oled = mic_in;
   clock_divider clk_20khz (CLOCK, 2499, clk_20k);
   clock_divider clk_5hz (CLOCK, 9999999, clk_5); //4999999
   
     Audio_Capture audio_cap (
     .CLK(CLOCK),                  // 100MHz clock
     .cs(clk_20k),                   // sampling clock, 20kHz
     .MISO(J_MIC3_Pin3),                 // J_MIC3_Pin3, serial mic input
     .clk_samp(J_MIC3_Pin1),            // J_MIC3_Pin1
     .sclk(J_MIC3_Pin4),            // J_MIC3_Pin4, MIC3 serial clock
     .sample(mic_in));     // 12-bit audio sample data
     
   
   

always @ (posedge clk_20k) 

 begin

     if (peak_volume_sample_count == 4000) 
         begin
         peak_volume_sample_count <= 0;
         peak_volume_display <= peak_volume;
         led_reg_peak_display <= led_reg_peak;

         lmh_switcher <= (peak_volume > 10) ? 2 : (peak_volume > 4) ? 1 : 0;
         peak_volume <= 0;
         led_reg_peak <= 0;
         end
        
     else begin //when  peak_volume_sample_count < 4000
         peak_volume_sample_count <= peak_volume_sample_count + 1;
    
    //need include below 2048????? 0???
         if (mic_in > 3968 ) begin
            led_reg <= 16'b1111_1111_1111_1111;
            led_reg_peak <= 16'b1111_1111_1111_1111;
            peak_volume <= 15; end
            
         else if (mic_in > 3840 ) begin
             led_reg <= 16'b0111_1111_1111_1111;
             led_reg_peak <= (peak_volume > 14) ? led_reg_peak : 16'b0111_1111_1111_1111;
             peak_volume <= (peak_volume > 14) ? peak_volume : 14; end
             
         else if (mic_in > 3712 ) begin
             led_reg <= 16'b0011_1111_1111_1111;
             led_reg_peak <= (peak_volume > 13) ? led_reg_peak : 16'b0011_1111_1111_1111;
             peak_volume <= (peak_volume > 13) ? peak_volume : 13; end
             
         else if (mic_in > 3584 ) begin
             led_reg_peak <= (peak_volume > 12) ? led_reg_peak : 16'b0001_1111_1111_1111;
             led_reg <= 16'b0001_1111_1111_1111;
             peak_volume <= (peak_volume > 12) ? peak_volume : 12; end
             
         else if (mic_in > 3456 ) begin
             led_reg_peak <= (peak_volume > 11) ? led_reg_peak : 16'b0000_1111_1111_1111;
             led_reg <= 16'b0000_1111_1111_1111;
             peak_volume <= (peak_volume > 11) ? peak_volume : 11; end
             
         else if (mic_in > 3328 ) begin
             led_reg_peak <= (peak_volume > 10) ? led_reg_peak : 16'b0000_0111_1111_1111;
             led_reg <= 16'b0000_0111_1111_1111;
             peak_volume <= (peak_volume > 10) ? peak_volume : 10; end
             
         else if (mic_in > 3200 ) begin
             led_reg_peak <= (peak_volume > 9) ? led_reg_peak : 16'b0000_0011_1111_1111;
             led_reg <= 16'b0000_0011_1111_1111;
             peak_volume <= (peak_volume > 9) ? peak_volume : 9; end
             
         else if (mic_in > 3072 ) begin
             led_reg_peak <= (peak_volume > 8) ? led_reg_peak : 16'b0000_0001_1111_1111;
             led_reg <= 16'b0000_0001_1111_1111;
             peak_volume <= (peak_volume > 8) ? peak_volume : 8; end
             
         else if (mic_in > 2944 ) begin
             led_reg_peak <= (peak_volume > 7) ? led_reg_peak : 16'b0000_0000_1111_1111;
             led_reg <= 16'b0000_0000_1111_1111;
             peak_volume <= (peak_volume > 7) ? peak_volume : 7; end
             
         else if (mic_in > 2816 ) begin
             led_reg_peak <= (peak_volume > 6) ? led_reg_peak : 16'b0000_0000_0111_1111;
             led_reg <= 16'b0000_0000_0111_1111;
             peak_volume <= (peak_volume > 6) ? peak_volume : 6; end
             
         else if (mic_in > 2688 ) begin
             led_reg_peak <= (peak_volume > 5) ? led_reg_peak : 16'b0000_0000_0011_1111;
             led_reg <= 16'b0000_0000_0011_1111;
             peak_volume <= (peak_volume > 5) ? peak_volume : 5; end
             
         else if (mic_in >= 2560  ) begin
             led_reg_peak <= (peak_volume > 4) ? led_reg_peak : 16'b0000_0000_0001_1111;
             led_reg <= 16'b0000_0000_0001_1111;
             peak_volume <= (peak_volume > 4) ? peak_volume : 4; end
             
         else if (mic_in > 2432 ) begin
             led_reg_peak <= (peak_volume > 3) ? led_reg_peak : 16'b0000_0000_0000_1111;
             led_reg <= 16'b0000_0000_0000_1111;
             peak_volume <= (peak_volume > 3) ? peak_volume : 3; end
             
         else if (mic_in > 2304 ) begin
             led_reg_peak <= (peak_volume > 2) ? led_reg_peak : 16'b0000_0000_0000_0111;
             led_reg <= 16'b0000_0000_0000_0111;
             peak_volume <= (peak_volume > 2) ? peak_volume : 2; end
             
         else if (mic_in > 2176 ) begin
             led_reg_peak <= (peak_volume > 1) ? led_reg_peak : 16'b0000_0000_0000_0011;
             led_reg <= 16'b0000_0000_0000_0011;
             peak_volume <= (peak_volume > 1) ? peak_volume : 1; end
             
         else if (mic_in > 2048  ) begin
             led_reg_peak <= (peak_volume > 0) ? led_reg_peak : 16'b0000_0000_0000_0001;
             led_reg <= 16'b0000_0000_0000_0001;
             peak_volume <= (peak_volume > 0) ? peak_volume : 0; end
             
         else  begin
             led_reg_peak <= (peak_volume > 0) ? led_reg_peak : 16'b0000_0000_0000_0000;
             led_reg <= 16'b0000_0000_0000_0000;
             peak_volume <= (peak_volume > 0) ? peak_volume : 0; end
     end
     
     
     
     anode_switcher = sw1 ? ~anode_switcher : 0; // blocking =, directly change anode_switcher

     case (anode_switcher)

     0:  //always show this even if sw1 is off
      case(peak_volume_display) //segment
         15: begin an_reg <= 4'b1110; seg_reg <= 7'b0001110; end  //F
         14: begin an_reg <= 4'b1110; seg_reg <= 7'b0000110; end  //E
         13: begin an_reg <= 4'b1110; seg_reg <= 7'b0100001; end  //d
         12: begin an_reg <= 4'b1110; seg_reg <= 7'b1000110; end  //C
         11: begin an_reg <= 4'b1110; seg_reg <= 7'b0000011; end  //b
         10: begin an_reg <= 4'b1110; seg_reg <= 7'b0001000; end  //A
         9: begin an_reg <= 4'b1110; seg_reg <= 7'b0010000; end  //9
         8: begin an_reg <= 4'b1110; seg_reg <= 7'b0000000; end  //8
         7: begin an_reg <= 4'b1110; seg_reg <= 7'b1111000; end  //7
         6: begin an_reg <= 4'b1110; seg_reg <= 7'b0000010; end  //6
         5: begin an_reg <= 4'b1110; seg_reg <= 7'b0010010; end  //5
         4: begin an_reg <= 4'b1110; seg_reg <= 7'b0011001; end  //4
         3: begin an_reg <= 4'b1110; seg_reg <= 7'b0110000; end  //3
         2: begin an_reg <= 4'b1110; seg_reg <= 7'b0100100; end  //2
         1: begin an_reg <= 4'b1110; seg_reg <= 7'b1111001; end  //1
         0: begin an_reg <= 4'b1110; seg_reg <= 7'b1000000; end   //0
         endcase
     
     1:  //only activate when sw1 on
         case(lmh_switcher) //segment
             0: begin an_reg <= 4'b0111; seg_reg <= 7'b1000111; end  //L
             1: begin an_reg <= 4'b0111; seg_reg <= 7'b1101010; end  //M
             2: begin an_reg <= 4'b0111; seg_reg <= 7'b0001001; end  //H
         endcase
     endcase
                         
                 
 end
endmodule
