`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: Nearest level modulation
// Module Name: nlm_module
// Tool Versions: vivado 2022.2
// Description: this module conatins the algorithm to calculate the value of M.
//////////////////////////////////////////////////////////////////////////////////

module nlm_module(
input [6:0] sine_sample,
output [2:0] M // M = number of submodules to be inserted //
    );
    assign M = ((sine_sample * 5)+50)/100; //calculation using nlm//
                                           
endmodule
