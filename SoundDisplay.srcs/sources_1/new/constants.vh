//CONSTANTS

// Screen dimmensions
`define WIDTH 96
`define HEIGHT 64

// Colors
`define BLACK 16'b0
`define WHITE ~`BLACK
`define MAGENTA 16'b11111_000000_11111
`define CYAN 16'b00000_111111_11111
`define YELLOW 16'b11111_111111_00000
`define GREEN 16'b00000_111111_00000
`define RED 16'b11111_000000_00000
`define BLUE 16'b00000_000000_11111
`define ORANGE 16'b11111_100110_00000
`define GREY 16'b01100_011000_01100
`define NUS_BLUE 16'b01110_011010_11111
`define DARK_MODE 16'b00100_00111_00100
`define MAROON 16'b10011_000000_00000


// Bit numbers for various
`define LDBIT       15
`define OLEDBIT     15
`define ANBIT       3
`define SEGDPBIT    7 //with dp
`define SEGBIT      6 //without dp
`define COLBIT      15 //colour
`define PIXELBIT    12 // Pixel_index from oled_display
`define PIXELXYBIT  6
// To clear AN/SEG
`define CLR_AN  ~4'b0
`define CLR_SEG ~8'b0

// 7SEG DIGITS
`define DIG0    7'b1000000
`define DIG1    7'b1111001
`define DIG2    7'b0100100
`define DIG3    7'b0110000
`define DIG4    7'b0011001
`define DIG5    7'b0010010
`define DIG6    7'b0000010
`define DIG7    7'b1111000
`define DIG8    7'b0
`define DIG9    7'b0010000   
// char
//`define CHAR_P  7'b0001100
//`define CHAR_O  7'b1000000
//`define CHAR_N  7'b0101011
//`define CHAR_G  7'b0010000


////////////////////////////////////////////////////
////////////////      VOL BAR      ////////////////
//////////////////////////////////////////////////

// Vol Bar Levels
`define LVLD 4
`define LVLH 2
`define LVL1 60
`define LVL2 (`LVL1 - `LVLD)
`define LVL3 (`LVL2 - `LVLD)
`define LVL4 (`LVL3 - `LVLD)
`define LVL5 (`LVL4 - `LVLD)
`define LVL6 (`LVL5 - `LVLD)
`define LVL7 (`LVL6 - `LVLD)
`define LVL8 (`LVL7 - `LVLD)
`define LVL9 (`LVL8 - `LVLD)
`define LVL10 (`LVL9 - `LVLD)
`define LVL11 (`LVL10 - `LVLD)
`define LVL12 (`LVL11 - `LVLD)
`define LVL13 (`LVL12 - `LVLD)
`define LVL14 (`LVL13 - `LVLD)
`define LVL15 (`LVL14 - `LVLD)


//Sourced from https://github.com/hughjazzman/EE2026-FPGA-Project/blob/master/sources_1/new/definitions.vh