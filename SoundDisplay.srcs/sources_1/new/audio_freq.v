`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2021 20:55:07
// Design Name: 
// Module Name: audio_freq
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


module audio_freq(input CLK, input [11:0] MIC_IN, output reg [15:0] SOUNDFREQ = 0,
    input [31:0] M, output reg [2:0] FREQ_RANGE = 0,
    
    output reg [6:0] seg_reg,
    output reg [3:0] an_reg
    
    );

    reg [31:0] COUNTER = 0;
    reg SOUNDPERIOD = 0;
    reg [12:0] SOUNDCOUNTER = 0;
    reg [31:0] FREQ = 0;
    reg SOUNDRESET = 0;
    
    
     reg [1:0] anode_switcher = 0;////////////////////////////
    reg [3:0] digit3 = 0;
    reg [3:0] digit2 = 0;
    reg [3:0] digit1 = 0;
    reg [3:0] digit0 = 0;
    wire clk_20k;
  
  clock_divider clk_20khz (CLK, 2499, clk_20k);

    
    

    always @ (posedge CLK) 
    begin
        COUNTER <= COUNTER +1;
        
        SOUNDRESET = 0;
        
        if(MIC_IN > 2175)
            SOUNDPERIOD <= 1;
        else
            SOUNDPERIOD <= 0;
       
        if(COUNTER == M)
        begin
            COUNTER <= 0;
            FREQ = 5 * SOUNDCOUNTER;
            FREQ_RANGE = FREQ < 30 ? 0 : FREQ < 250 ? 1 : FREQ < 350 ? 2 : FREQ < 450 ? 3 : 4;
            SOUNDRESET = 1;
            
            if      (FREQ < 100)  SOUNDFREQ = 16'b0;
            else if (FREQ < 200)  SOUNDFREQ = 16'b1;
            else if (FREQ < 300)  SOUNDFREQ = 16'b11;
            else if (FREQ < 400)  SOUNDFREQ = 16'b111;
            else if (FREQ < 500)  SOUNDFREQ = 16'b1111;
            else if (FREQ < 600)  SOUNDFREQ = 16'b11111;
            else if (FREQ < 700)  SOUNDFREQ = 16'b111111;
            else if (FREQ < 800)  SOUNDFREQ = 16'b1111111;
            else if (FREQ < 900)  SOUNDFREQ = 16'b11111111;
            else if (FREQ < 1000) SOUNDFREQ = 16'b111111111;
            else if (FREQ < 1100) SOUNDFREQ = 16'b1111111111;
            else if (FREQ < 1200) SOUNDFREQ = 16'b11111111111;
            else if (FREQ < 1300) SOUNDFREQ = 16'b111111111111;
            else if (FREQ < 1400) SOUNDFREQ = 16'b1111111111111;
            else if (FREQ < 1500) SOUNDFREQ = 16'b11111111111111;
            else if (FREQ < 1600) SOUNDFREQ = 16'b111111111111111;
            else                  SOUNDFREQ = 16'b1111111111111111;

        end
///////////////////////////////////////////////////////        
            anode_switcher = anode_switcher + 1;
            digit3 = (FREQ / 1000) % 10;
            
            case (anode_switcher)
                0:  //always show this even if sw1 is off
    
                 case(FREQ % 10) //segment
                    9: begin an_reg = 4'b1110; seg_reg = 7'b0010000; end  //9
                    8: begin an_reg = 4'b1110; seg_reg = 7'b0000000; end  //8
                    7: begin an_reg = 4'b1110; seg_reg = 7'b1111000; end  //7
                    6: begin an_reg = 4'b1110; seg_reg = 7'b0000010; end  //6
                    5: begin an_reg = 4'b1110; seg_reg = 7'b0010010; end  //5
                    4: begin an_reg = 4'b1110; seg_reg = 7'b0011001; end  //4
                    3: begin an_reg = 4'b1110; seg_reg = 7'b0110000; end  //3
                    2: begin an_reg = 4'b1110; seg_reg = 7'b0100100; end  //2
                    1: begin an_reg = 4'b1110; seg_reg = 7'b1111001; end  //1
                    0: begin an_reg = 4'b1110; seg_reg = 7'b1000000; end   //0
                    endcase
                
                1:  //always show this even if sw1 is off
                 case((FREQ / 10) % 10) //segment
                 9: begin an_reg = 4'b1101; seg_reg = 7'b0010000; end  //9
                 8: begin an_reg = 4'b1101; seg_reg = 7'b0000000; end  //8
                 7: begin an_reg = 4'b1101; seg_reg = 7'b1111000; end  //7
                 6: begin an_reg = 4'b1101; seg_reg = 7'b0000010; end  //6
                 5: begin an_reg = 4'b1101; seg_reg = 7'b0010010; end  //5
                 4: begin an_reg = 4'b1101; seg_reg = 7'b0011001; end  //4
                 3: begin an_reg = 4'b1101; seg_reg = 7'b0110000; end  //3
                 2: begin an_reg = 4'b1101; seg_reg = 7'b0100100; end  //2
                 1: begin an_reg = 4'b1101; seg_reg = 7'b1111001; end  //1
                 0: begin an_reg = 4'b1101; seg_reg = 7'b1000000; end   //0
                    endcase
                
                2:  //always show this even if sw1 is off
                 case((FREQ / 100) % 10) //segment
                    9: begin an_reg = 4'b1011; seg_reg = 7'b0010000; end  //9
                 8: begin an_reg = 4'b1011; seg_reg = 7'b0000000; end  //8
                 7: begin an_reg = 4'b1011; seg_reg = 7'b1111000; end  //7
                 6: begin an_reg = 4'b1011; seg_reg = 7'b0000010; end  //6
                 5: begin an_reg = 4'b1011; seg_reg = 7'b0010010; end  //5
                 4: begin an_reg = 4'b1011; seg_reg = 7'b0011001; end  //4
                 3: begin an_reg = 4'b1011; seg_reg = 7'b0110000; end  //3
                 2: begin an_reg = 4'b1011; seg_reg = 7'b0100100; end  //2
                 1: begin an_reg = 4'b1011; seg_reg = 7'b1111001; end  //1
                 0: begin an_reg = 4'b1011; seg_reg = 7'b1000000; end   //0
                    endcase
                
                3:  //always show this even if sw1 is off
                 case((FREQ / 1000) % 10) //segment
                    9: begin an_reg = 4'b0111; seg_reg = 7'b0010000; end  //9
                     8: begin an_reg = 4'b0111; seg_reg = 7'b0000000; end  //8
                     7: begin an_reg = 4'b0111; seg_reg = 7'b1111000; end  //7
                     6: begin an_reg = 4'b0111; seg_reg = 7'b0000010; end  //6
                     5: begin an_reg = 4'b0111; seg_reg = 7'b0010010; end  //5
                     4: begin an_reg = 4'b0111; seg_reg = 7'b0011001; end  //4
                     3: begin an_reg = 4'b0111; seg_reg = 7'b0110000; end  //3
                     2: begin an_reg = 4'b0111; seg_reg = 7'b0100100; end  //2
                     1: begin an_reg = 4'b0111; seg_reg = 7'b1111001; end  //1
                     0: begin an_reg = 4'b0111; seg_reg = 7'b1000000; end   //0
                    endcase
                
               endcase
           
    end
    
    always @ (posedge SOUNDPERIOD, posedge SOUNDRESET)
    begin
        if (SOUNDRESET == 1)
            SOUNDCOUNTER <= 0;
        else 
            SOUNDCOUNTER <= SOUNDCOUNTER + 1;
    end
    
    
    

endmodule
