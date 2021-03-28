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
    
    //switches & buttons
    input [15:0] sw, input BTNC, BTNL, BTNR, BTND,
    //task2a
    input CLOCK,
    output reg [15:0] led,
    output reg [3:0] an, output reg [6:0] seg,
    output [7:0] JB
    );
    
    //audio task2a 
    wire [11:0] mic_in_oled;
    wire [3:0] an_reg;
    wire [6:0] seg_reg; 
    wire [15:0] led_reg; 
    wire [15:0] led_reg_peak_display;
    wire [3:0] peak_volume_display;

    //WIRES
    wire [12:0] my_pix_index;
        
    //DIFFERENT DISPLAYS FOR MODULES
    wire [15:0] volume_bar_data;
    wire [15:0] alioto_data;
    wire [15:0] my_oled_data;
         
    //CLOCKS & SINGLE PULSE
    wire clk_20k, sixp25clk;
    wire my_sp, sp_left, sp_right, sp_down; 
    
    clock_divider sixp25mhz (CLOCK, 7, sixp25clk); 
    single_pulse_circuit pulse (BTNC, CLOCK, my_sp);
    single_pulse_circuit pulse_left (BTNL, CLOCK, sp_left);
    single_pulse_circuit pulse_right (BTNR, CLOCK, sp_right);
    single_pulse_circuit pulse_down (BTND, CLOCK, sp_down);
    
    //AUDIO INSTANCE
         task_2a myaudio(
               J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
               J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
               J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
               CLOCK, sw[0], sw[1],
               mic_in_oled,
               an_reg, seg_reg, led_reg, led_reg_peak_display,
               peak_volume_display //link to volume bar
       );

       always @ (posedge CLOCK)
       begin
           led <= (sw[0]) ?  led_reg_peak_display : led_reg;
           seg <= seg_reg;
           an <= an_reg;   //////////////////////
       end
     
        //OLED INSTANCE
        wire  my_samp_pix, my_test_state,my_fb,send_pix;
        
        Oled_Display myOled (
            .clk(sixp25clk), .reset(my_sp),
            .frame_begin(my_fb), .sending_pixels(send_pix), .sample_pixel(my_samp_pix),
            .pixel_index(my_pix_index),
            .pixel_data(my_oled_data),
            .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]),
            .teststate(my_test_state)
         );
         
        //TASK 2A,B (VOLUME BAR DISPLAY) 
        volume_bar bar (.mic_in(mic_in_oled), .peak_volume(peak_volume_display), .my_pix_index(my_pix_index), .CLOCK(CLOCK), 
        .BTNC(BTNC), .BTNL(BTNL), .BTNR(BTNR), .BTND(BTND), .theme_swap(sw[15]), .border_swap(sw[14]), .border_on(sw[13]), 
        .volume_on(sw[12]), .sw_mic_peak(sw[1]), .volume_bar_data(volume_bar_data));
        
        //FUNCTION: ALIOTO BITMAP 
        bitmap_1 alioto (CLOCK, my_pix_index, alioto_data);
        
        //DISPLAY CONTROL MODULE
        function_displayer fn (CLOCK, sw[11], volume_bar_data, alioto_data, my_oled_data);
    
endmodule
