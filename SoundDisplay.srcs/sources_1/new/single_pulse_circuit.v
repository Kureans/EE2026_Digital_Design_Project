`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 23:23:59
// Design Name: 
// Module Name: single_pulse_circuit
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


module single_pulse_circuit(input my_pb, input sp_clock,output my_sp);

    wire my_dff_out_1, my_dff_out_2;
    wire slowclock;
//    reg [7:0] eight_bit_counter = 0;
    
    clock_divider unitx (.CLOCK(sp_clock), .my_m_value(4166665), .new_clock(slowclock));
    my_dff unit0 (.D(my_pb), .dff_clock(slowclock), .Q(my_dff_out_1));
    my_dff unit1 (.D(my_dff_out_1), .dff_clock(slowclock), .Q(my_dff_out_2));
    
//    always @ (posedge slowclock) begin
//        if (my_sp == 1) begin
//        eight_bit_counter <= eight_bit_counter + 1;
//        end
//    end
        
    
    assign my_sp = my_dff_out_1 & ~my_dff_out_2;
    
endmodule
