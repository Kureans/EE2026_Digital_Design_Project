
module volume_bar(input [11:0] mic_in, input [3:0] peak_volume, input CLOCK, input BTNC, BTNL, BTNR, BTND, theme_og, theme_nus, border_1, border_3, border_on, volume_on, sw_mic_peak, output [7:0] JB);
 
wire my_fb,send_pix, my_sp, sp_left, sp_right, sp_down, my_samp_pix, my_test_state;
    wire [12:0] my_pix_index;
    reg [15:0] my_oled_data;
    reg pixel_border_1, pixel_border_3 = 0;
    reg [6:0] x_coord; //x-coordinate
    reg [6:0] y_coord; //y-coodinate
    reg [15:0] colour_theme_bg;
    reg [15:0] colour_theme_border;
    reg [6:0] x_left = 7'd37;
    reg [6:0] x_right = 7'd57;
    
    wire clk_20k;
    wire sixp25clk;
   
 
clock_divider sixp25mhz (CLOCK, 7, sixp25clk); 
single_pulse_circuit pulse (BTNC, CLOCK, my_sp);
single_pulse_circuit pulse_left (BTNL, CLOCK, sp_left);
single_pulse_circuit pulse_right (BTNR, CLOCK, sp_right);
single_pulse_circuit pulse_down (BTND, CLOCK, sp_down);
 
Oled_Display myOled (
    .clk(sixp25clk), .reset(my_sp),
    .frame_begin(my_fb), .sending_pixels(send_pix), .sample_pixel(my_samp_pix),
    .pixel_index(my_pix_index),
    .pixel_data(my_oled_data),
    .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]),
    .teststate(my_test_state)
 );
 
 always @ (posedge sixp25clk) begin
      
     //COLOUR THEME
     if (theme_og == 1) begin
         colour_theme_bg <= 16'd0;
         colour_theme_border <= 16'b11111_111111_11111;
         end
     if (theme_nus == 1) begin
         colour_theme_bg <= 16'b01110_011010_11111;
         colour_theme_border <= 16'b11111_101001_00000;
         end
     
     //MOVEMENT
     if (sp_left == 1) begin
         x_left <= 7;
         x_right <= 27;
         end
     
     if (sp_right == 1) begin
         x_left <= 67;
         x_right <= 87;
         end  
     
     if (sp_down == 1) begin
         x_left <= 37;
         x_right <= 57;
         end
         
     //BORDER CONTROL    
     if (border_1 == 1) begin
         pixel_border_1 <= 1;
         pixel_border_3 <= 0;
         end
         
     if (border_3 == 1) begin
         pixel_border_3 <= 1;
         pixel_border_1 <= 0;    
     end
     
     x_coord = my_pix_index % 96;
     y_coord = my_pix_index / 96;
     
     if (pixel_border_1 == 1) begin  //creating white border of pixel width 1
         if (y_coord == 0 || y_coord == 63 || x_coord == 0 || x_coord == 95)  //borders
             if (border_on == 1)
                 my_oled_data <= colour_theme_border; //ORANGE
             else
                 my_oled_data <= colour_theme_bg;            
         else if (x_coord >= x_left && x_coord <= x_right && volume_on == 1) begin
         if (sw_mic_peak == 0) begin
             if (y_coord >= 9 && y_coord <= 10 && mic_in > 3840) //1
                 my_oled_data <= 16'hF800;
             else if (y_coord >= 12 && y_coord <= 13 && mic_in > 3712)//2
                 my_oled_data <= 16'hF800;
             else if (y_coord >= 15 && y_coord <= 16 && mic_in > 3584)//3
                 my_oled_data <= 16'hF800;
             else if (y_coord >= 18 && y_coord <= 19 && mic_in > 3456)//4
                 my_oled_data <= 16'hF800;
             else if (y_coord >= 21 && y_coord <= 22 && mic_in > 3328)//5
                 my_oled_data <= 16'hF800;
             else if (y_coord >= 24 && y_coord <= 25 && mic_in > 3200)//6
                 my_oled_data <= 16'hFFE0;
             else if (y_coord >= 27 && y_coord <= 28 && mic_in > 3072)//7
                 my_oled_data <= 16'hFFE0;
             else if (y_coord >= 30 && y_coord <= 31 && mic_in > 2944)//8
                 my_oled_data <= 16'hFFE0;
             else if (y_coord >= 33 && y_coord <= 34 && mic_in > 2816)//9
                 my_oled_data <= 16'hFFE0;
             else if (y_coord >= 36 && y_coord <= 37 && mic_in > 2688)//10
                 my_oled_data <= 16'hFFE0;
             else if (y_coord >= 39 && y_coord <= 40 && mic_in > 2560)//11
                 my_oled_data <= 16'h07E0;
             else if (y_coord >= 42 && y_coord <= 43 && mic_in > 2432)//12
                 my_oled_data <= 16'h07E0;
             else if (y_coord >= 45 && y_coord <= 46 && mic_in > 2304)//13
                 my_oled_data <= 16'h07E0;
             else if (y_coord >= 48 && y_coord <= 49 && mic_in > 2176)//14
                 my_oled_data <= 16'h07E0;
             else if (y_coord >= 51 && y_coord <= 52 && mic_in > 2048)//15
                 my_oled_data <= 16'h07E0;
         end
         if (sw_mic_peak) begin
         if (y_coord >= 9 && y_coord <= 10 && peak_volume == 15) //1
                          my_oled_data <= 16'hF800;
                      else if (y_coord >= 12 && y_coord <= 13 && peak_volume >= 14)//2
                          my_oled_data <= 16'hF800;
                      else if (y_coord >= 15 && y_coord <= 16 && peak_volume >= 13)//3
                          my_oled_data <= 16'hF800;
                      else if (y_coord >= 18 && y_coord <= 19 && peak_volume >= 12)//4
                          my_oled_data <= 16'hF800;
                      else if (y_coord >= 21 && y_coord <= 22 && peak_volume >= 11)//5
                          my_oled_data <= 16'hF800;
                      else if (y_coord >= 24 && y_coord <= 25 && peak_volume >= 10)//6
                          my_oled_data <= 16'hFFE0;
                      else if (y_coord >= 27 && y_coord <= 28 && peak_volume >= 9)//7
                          my_oled_data <= 16'hFFE0;
                      else if (y_coord >= 30 && y_coord <= 31 && peak_volume >= 8)//8
                          my_oled_data <= 16'hFFE0;
                      else if (y_coord >= 33 && y_coord <= 34 && peak_volume >= 7)//9
                          my_oled_data <= 16'hFFE0;
                      else if (y_coord >= 36 && y_coord <= 37 && peak_volume >= 6)//10
                          my_oled_data <= 16'hFFE0;
                      else if (y_coord >= 39 && y_coord <= 40 && peak_volume >= 5)//11
                          my_oled_data <= 16'h07E0;
                      else if (y_coord >= 42 && y_coord <= 43 && peak_volume >= 4)//12
                          my_oled_data <= 16'h07E0;
                      else if (y_coord >= 45 && y_coord <= 46 && peak_volume >= 3)//13
                          my_oled_data <= 16'h07E0;
                      else if (y_coord >= 48 && y_coord <= 49 && peak_volume >= 2)//14
                          my_oled_data <= 16'h07E0;
                      else if (y_coord >= 51 && y_coord <= 52 && peak_volume >= 1)//15
                          my_oled_data <= 16'h07E0;
                  end
         end
             
         else
             my_oled_data <= colour_theme_bg; //BLUE
     end
     
     if (pixel_border_3 == 1) begin //creating white border of pixel width 3
         if (y_coord <= 2 || y_coord >= 61 || x_coord <= 2 || x_coord >= 93)  //borders
             if (border_on == 1)
             my_oled_data <= colour_theme_border; //ORANGE
             else
             my_oled_data <= colour_theme_bg;
         else if (x_coord >= x_left && x_coord <= x_right && volume_on == 1) begin
         if (sw_mic_peak == 0) begin
             if (y_coord >= 9 && y_coord <= 10 && mic_in > 3840) //1
                my_oled_data <= 16'hF800;
             else if (y_coord >= 12 && y_coord <= 13 && mic_in > 3712)//2
                my_oled_data <= 16'hF800;
             else if (y_coord >= 15 && y_coord <= 16 && mic_in > 3584)//3
                my_oled_data <= 16'hF800;
             else if (y_coord >= 18 && y_coord <= 19 && mic_in > 3456)//4
                my_oled_data <= 16'hF800;
             else if (y_coord >= 21 && y_coord <= 22 && mic_in > 3328)//5
                my_oled_data <= 16'hF800;
             else if (y_coord >= 24 && y_coord <= 25 && mic_in > 3200)//6
                my_oled_data <= 16'hFFE0;
             else if (y_coord >= 27 && y_coord <= 28 && mic_in > 3072)//7
                my_oled_data <= 16'hFFE0;
             else if (y_coord >= 30 && y_coord <= 31 && mic_in > 2944)//8
                my_oled_data <= 16'hFFE0;
             else if (y_coord >= 33 && y_coord <= 34 && mic_in > 2816)//9
                my_oled_data <= 16'hFFE0;
             else if (y_coord >= 36 && y_coord <= 37 && mic_in > 2688)//10
                my_oled_data <= 16'hFFE0;
             else if (y_coord >= 39 && y_coord <= 40 && mic_in > 2560)//11
                my_oled_data <= 16'h07E0;
             else if (y_coord >= 42 && y_coord <= 43 && mic_in > 2432)//12
                my_oled_data <= 16'h07E0;
             else if (y_coord >= 45 && y_coord <= 46 && mic_in > 2304)//13
                my_oled_data <= 16'h07E0;
             else if (y_coord >= 48 && y_coord <= 49 && mic_in > 2176)//14
                my_oled_data <= 16'h07E0;
             else if (y_coord >= 51 && y_coord <= 52 && mic_in > 2048)//15
                my_oled_data <= 16'h07E0;
             end
          if (sw_mic_peak == 1) begin
                      if (y_coord >= 9 && y_coord <= 10 && peak_volume == 15) //1
                                       my_oled_data <= 16'hF800;
                                   else if (y_coord >= 12 && y_coord <= 13 && peak_volume >= 14)//2
                                       my_oled_data <= 16'hF800;
                                   else if (y_coord >= 15 && y_coord <= 16 && peak_volume >= 13)//3
                                       my_oled_data <= 16'hF800;
                                   else if (y_coord >= 18 && y_coord <= 19 && peak_volume >= 12)//4
                                       my_oled_data <= 16'hF800;
                                   else if (y_coord >= 21 && y_coord <= 22 && peak_volume >= 11)//5
                                       my_oled_data <= 16'hF800;
                                   else if (y_coord >= 24 && y_coord <= 25 && peak_volume >= 10)//6
                                       my_oled_data <= 16'hFFE0;
                                   else if (y_coord >= 27 && y_coord <= 28 && peak_volume >= 9)//7
                                       my_oled_data <= 16'hFFE0;
                                   else if (y_coord >= 30 && y_coord <= 31 && peak_volume >= 8)//8
                                       my_oled_data <= 16'hFFE0;
                                   else if (y_coord >= 33 && y_coord <= 34 && peak_volume >= 7)//9
                                       my_oled_data <= 16'hFFE0;
                                   else if (y_coord >= 36 && y_coord <= 37 && peak_volume >= 6)//10
                                       my_oled_data <= 16'hFFE0;
                                   else if (y_coord >= 39 && y_coord <= 40 && peak_volume >= 5)//11
                                       my_oled_data <= 16'h07E0;
                                   else if (y_coord >= 42 && y_coord <= 43 && peak_volume >= 4)//12
                                       my_oled_data <= 16'h07E0;
                                   else if (y_coord >= 45 && y_coord <= 46 && peak_volume >= 3)//13
                                       my_oled_data <= 16'h07E0;
                                   else if (y_coord >= 48 && y_coord <= 49 && peak_volume >= 2)//14
                                       my_oled_data <= 16'h07E0;
                                   else if (y_coord >= 51 && y_coord <= 52 && peak_volume >= 1)//15
                                       my_oled_data <= 16'h07E0;
                               end
             end
         else
             my_oled_data <= colour_theme_bg; //BLUE
         end
      
  end
 
//GREEN = 16'h07E0
 //ORANGE == 16'b11111_101001_00000
 //BLUE == 16'b01110_011010_11111
 
endmodule