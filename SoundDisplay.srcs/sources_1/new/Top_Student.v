`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    
    //task2a
    input CLOCK, input sw0, sw_mic_peak,
    output reg [15:0] led,
    output reg [3:0] an, output reg [6:0] seg,
 
    //task2b
    input BTNC, BTNL, BTNR, BTND, theme_og, theme_nus, border_1, border_3, border_on, volume_on,
    output [7:0] JB
    );
    
    //audio task2a 
    wire [11:0] mic_in_oled;
    wire [3:0] an_reg;
    wire [6:0] seg_reg; 
    wire [15:0] led_reg; 
    wire [15:0] led_reg_peak_display;
    wire [3:0] peak_volume_display;


     task_2a task2a_instance(
                J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
                J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
                J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
                CLOCK, sw0, sw_mic_peak,
                mic_in_oled,
                an_reg, seg_reg, led_reg, led_reg_peak_display,
                
                peak_volume_display //link to volume bar
        );
        
    
    
     always @ (posedge CLOCK)
        begin
            led <= (sw0) ?  led_reg_peak_display : led_reg;
            seg <= seg_reg;
            an <= an_reg;   //////////////////////
        end
        
    //task2b
    
    
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
     
        volume_bar bar (mic_in_oled, peak_volume_display, CLOCK, BTNC, BTNL, BTNR, BTND, theme_og, theme_nus, 
                        border_1, border_3, border_on, volume_on, sw_mic_peak, JB
                        );


    
endmodule
