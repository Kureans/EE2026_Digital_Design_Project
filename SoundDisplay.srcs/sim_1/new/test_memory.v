`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 11:51:17
// Design Name: 
// Module Name: test_memory
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


module test_memory();
          reg [7:0] memory [0:5];
          integer   index;

          initial
             $readmemh("C:\Users\reali\Desktop\anything\test.txt", memory);
          initial begin
             for(index = 0; index < 6; index = index + 1)
             $display("memory[%d] = %h", index[4:0], memory[index]);
 
          end
       endmodule // testmemory

