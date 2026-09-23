`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: sine wave generator using look up table 
// Module Name: sin_generator
// Tool Versions: vivado 2022.2
// Description: This module has been made with the concept of look up table It increments
// the LUT address on every clock cycle and outputs the corresponding sine value, repeating 
// the sequence continuously after the last sample.
//////////////////////////////////////////////////////////////////////////////////



module sin_generator(
// inputs //
    input clk, // Clock input used to update the LUT address every clock cycle.//
    input rst, //Asynchronous reset signal that resets the address counter to zero.//
    output reg [6:0] sine_sample); // 7-bit output register that stores the current sine sample from the LUT.//

reg [3:0] addr;

always @(posedge clk or posedge rst)
begin
    if (rst) // If reset is asserted, the address counter is reset to 0,
             // starting the sine wave from the first sample.
        addr <= 4'd0;
    else if (addr == 4'd10)
        addr <= 4'd0;
    else
        addr <= addr + 1'b1; // increment the address by 1 on every clock cycle to move to the next sine sample.//
end

always @(*)
begin
    case (addr)
//Checks the current address and selects the corresponding sine value from the Look-Up Table.//
        4'd0  : sine_sample = 7'd0;
        4'd1  : sine_sample = 7'd25;
        4'd2  : sine_sample = 7'd50;
        4'd3  : sine_sample = 7'd74;
        4'd4  : sine_sample = 7'd95;
        4'd5  : sine_sample = 7'd100;
        4'd6  : sine_sample = 7'd95;
        4'd7  : sine_sample = 7'd74;
        4'd8  : sine_sample = 7'd50;
        4'd9  : sine_sample = 7'd25;
        4'd10 : sine_sample = 7'd0;

        default : sine_sample = 7'd0;

    endcase
end

endmodule
