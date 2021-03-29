
module volume_bar(input [11:0] mic_in, input [3:0] peak_volume, input [12:0] my_pix_index, input CLOCK, input my_sp, sp_left, sp_right, sp_down, theme_swap, border_swap, border_on, volume_on, sw_mic_peak, 
output reg [15:0] volume_bar_data);
 
    reg pixel_border_1, pixel_border_3 = 0;
    wire [6:0] x_coord; //x-coordinate
    wire [6:0] y_coord; //y-coodinate
    reg [15:0] colour_theme_bg;
    reg [15:0] colour_theme_border;
    reg [6:0] x_left = 7'd37;
    reg [6:0] x_right = 7'd57;
    
 assign x_coord = my_pix_index % 96;
 assign y_coord = my_pix_index / 96;
 always @ (posedge CLOCK) begin

     //COLOUR THEME
     if (theme_swap == 0) begin
         colour_theme_bg <= 16'd0;
         colour_theme_border <= 16'b11111_111111_11111;
         end
     if (theme_swap == 1) begin
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
     if (border_swap == 0) begin
         pixel_border_1 <= 1;
         pixel_border_3 <= 0;
         end
         
     if (border_swap == 1) begin
         pixel_border_3 <= 1;
         pixel_border_1 <= 0;    
     end
     
     
     
     if (pixel_border_1 == 1) begin  //creating white border of pixel width 1
         if (y_coord == 0 || y_coord == 63 || x_coord == 0 || x_coord == 95)  //borders
             if (border_on == 1)
                 volume_bar_data <= colour_theme_border; //ORANGE
             else
                 volume_bar_data <= colour_theme_bg;            
         else if (x_coord >= x_left && x_coord <= x_right && volume_on == 1) begin
         if (sw_mic_peak == 0) begin
             if (y_coord >= 9 && y_coord <= 10 && mic_in > 3840) //1
                 volume_bar_data <= 16'hF800;
             else if (y_coord >= 12 && y_coord <= 13 && mic_in > 3712)//2
                 volume_bar_data <= 16'hF800;
             else if (y_coord >= 15 && y_coord <= 16 && mic_in > 3584)//3
                 volume_bar_data <= 16'hF800;
             else if (y_coord >= 18 && y_coord <= 19 && mic_in > 3456)//4
                 volume_bar_data <= 16'hF800;
             else if (y_coord >= 21 && y_coord <= 22 && mic_in > 3328)//5
                 volume_bar_data <= 16'hF800;
             else if (y_coord >= 24 && y_coord <= 25 && mic_in > 3200)//6
                 volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 27 && y_coord <= 28 && mic_in > 3072)//7
                 volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 30 && y_coord <= 31 && mic_in > 2944)//8
                 volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 33 && y_coord <= 34 && mic_in > 2816)//9
                 volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 36 && y_coord <= 37 && mic_in > 2688)//10
                 volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 39 && y_coord <= 40 && mic_in > 2560)//11
                 volume_bar_data <= 16'h07E0;
             else if (y_coord >= 42 && y_coord <= 43 && mic_in > 2432)//12
                 volume_bar_data <= 16'h07E0;
             else if (y_coord >= 45 && y_coord <= 46 && mic_in > 2304)//13
                 volume_bar_data <= 16'h07E0;
             else if (y_coord >= 48 && y_coord <= 49 && mic_in > 2176)//14
                 volume_bar_data <= 16'h07E0;
             else if (y_coord >= 51 && y_coord <= 52 && mic_in > 2048)//15
                 volume_bar_data <= 16'h07E0;
         end
         if (sw_mic_peak) begin
         if (y_coord >= 9 && y_coord <= 10 && peak_volume == 15) //1
                          volume_bar_data <= 16'hF800;
                      else if (y_coord >= 12 && y_coord <= 13 && peak_volume >= 14)//2
                          volume_bar_data <= 16'hF800;
                      else if (y_coord >= 15 && y_coord <= 16 && peak_volume >= 13)//3
                          volume_bar_data <= 16'hF800;
                      else if (y_coord >= 18 && y_coord <= 19 && peak_volume >= 12)//4
                          volume_bar_data <= 16'hF800;
                      else if (y_coord >= 21 && y_coord <= 22 && peak_volume >= 11)//5
                          volume_bar_data <= 16'hF800;
                      else if (y_coord >= 24 && y_coord <= 25 && peak_volume >= 10)//6
                          volume_bar_data <= 16'hFFE0;
                      else if (y_coord >= 27 && y_coord <= 28 && peak_volume >= 9)//7
                          volume_bar_data <= 16'hFFE0;
                      else if (y_coord >= 30 && y_coord <= 31 && peak_volume >= 8)//8
                          volume_bar_data <= 16'hFFE0;
                      else if (y_coord >= 33 && y_coord <= 34 && peak_volume >= 7)//9
                          volume_bar_data <= 16'hFFE0;
                      else if (y_coord >= 36 && y_coord <= 37 && peak_volume >= 6)//10
                          volume_bar_data <= 16'hFFE0;
                      else if (y_coord >= 39 && y_coord <= 40 && peak_volume >= 5)//11
                          volume_bar_data <= 16'h07E0;
                      else if (y_coord >= 42 && y_coord <= 43 && peak_volume >= 4)//12
                          volume_bar_data <= 16'h07E0;
                      else if (y_coord >= 45 && y_coord <= 46 && peak_volume >= 3)//13
                          volume_bar_data <= 16'h07E0;
                      else if (y_coord >= 48 && y_coord <= 49 && peak_volume >= 2)//14
                          volume_bar_data <= 16'h07E0;
                      else if (y_coord >= 51 && y_coord <= 52 && peak_volume >= 1)//15
                          volume_bar_data <= 16'h07E0;
                  end
         end
             
         else
             volume_bar_data <= colour_theme_bg; //BLUE
     end
     
     if (pixel_border_3 == 1) begin //creating white border of pixel width 3
         if (y_coord <= 2 || y_coord >= 61 || x_coord <= 2 || x_coord >= 93)  //borders
             if (border_on == 1)
             volume_bar_data <= colour_theme_border; //ORANGE
             else
             volume_bar_data <= colour_theme_bg;
         else if (x_coord >= x_left && x_coord <= x_right && volume_on == 1) begin
         if (sw_mic_peak == 0) begin
             if (y_coord >= 9 && y_coord <= 10 && mic_in > 3840) //1
                volume_bar_data <= 16'hF800;
             else if (y_coord >= 12 && y_coord <= 13 && mic_in > 3712)//2
                volume_bar_data <= 16'hF800;
             else if (y_coord >= 15 && y_coord <= 16 && mic_in > 3584)//3
                volume_bar_data <= 16'hF800;
             else if (y_coord >= 18 && y_coord <= 19 && mic_in > 3456)//4
                volume_bar_data <= 16'hF800;
             else if (y_coord >= 21 && y_coord <= 22 && mic_in > 3328)//5
                volume_bar_data <= 16'hF800;
             else if (y_coord >= 24 && y_coord <= 25 && mic_in > 3200)//6
                volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 27 && y_coord <= 28 && mic_in > 3072)//7
                volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 30 && y_coord <= 31 && mic_in > 2944)//8
                volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 33 && y_coord <= 34 && mic_in > 2816)//9
                volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 36 && y_coord <= 37 && mic_in > 2688)//10
                volume_bar_data <= 16'hFFE0;
             else if (y_coord >= 39 && y_coord <= 40 && mic_in > 2560)//11
                volume_bar_data <= 16'h07E0;
             else if (y_coord >= 42 && y_coord <= 43 && mic_in > 2432)//12
                volume_bar_data <= 16'h07E0;
             else if (y_coord >= 45 && y_coord <= 46 && mic_in > 2304)//13
                volume_bar_data <= 16'h07E0;
             else if (y_coord >= 48 && y_coord <= 49 && mic_in > 2176)//14
                volume_bar_data <= 16'h07E0;
             else if (y_coord >= 51 && y_coord <= 52 && mic_in > 2048)//15
                volume_bar_data <= 16'h07E0;
             end
          if (sw_mic_peak == 1) begin
                      if (y_coord >= 9 && y_coord <= 10 && peak_volume == 15) //1
                                       volume_bar_data <= 16'hF800;
                                   else if (y_coord >= 12 && y_coord <= 13 && peak_volume >= 14)//2
                                       volume_bar_data <= 16'hF800;
                                   else if (y_coord >= 15 && y_coord <= 16 && peak_volume >= 13)//3
                                       volume_bar_data <= 16'hF800;
                                   else if (y_coord >= 18 && y_coord <= 19 && peak_volume >= 12)//4
                                      volume_bar_data <= 16'hF800;
                                   else if (y_coord >= 21 && y_coord <= 22 && peak_volume >= 11)//5
                                       volume_bar_data <= 16'hF800;
                                   else if (y_coord >= 24 && y_coord <= 25 && peak_volume >= 10)//6
                                       volume_bar_data <= 16'hFFE0;
                                   else if (y_coord >= 27 && y_coord <= 28 && peak_volume >= 9)//7
                                       volume_bar_data <= 16'hFFE0;
                                   else if (y_coord >= 30 && y_coord <= 31 && peak_volume >= 8)//8
                                       volume_bar_data <= 16'hFFE0;
                                   else if (y_coord >= 33 && y_coord <= 34 && peak_volume >= 7)//9
                                       volume_bar_data <= 16'hFFE0;
                                   else if (y_coord >= 36 && y_coord <= 37 && peak_volume >= 6)//10
                                       volume_bar_data <= 16'hFFE0;
                                   else if (y_coord >= 39 && y_coord <= 40 && peak_volume >= 5)//11
                                       volume_bar_data <= 16'h07E0;
                                   else if (y_coord >= 42 && y_coord <= 43 && peak_volume >= 4)//12
                                       volume_bar_data <= 16'h07E0;
                                   else if (y_coord >= 45 && y_coord <= 46 && peak_volume >= 3)//13
                                       volume_bar_data <= 16'h07E0;
                                   else if (y_coord >= 48 && y_coord <= 49 && peak_volume >= 2)//14
                                       volume_bar_data <= 16'h07E0;
                                   else if (y_coord >= 51 && y_coord <= 52 && peak_volume >= 1)//15
                                       volume_bar_data <= 16'h07E0;
                               end
             end
         else
             volume_bar_data <= colour_theme_bg; //BLUE
         end
      
  end
 
//GREEN = 16'h07E0
 //ORANGE == 16'b11111_101001_00000
 //BLUE == 16'b01110_011010_11111
 
endmodule