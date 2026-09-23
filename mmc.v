`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: top module for capacitor voltage balancing
// Module Name: mmc
// Tool Versions: vivado 2022.2
// Description: this module itself contains no balancing algorithms we have initialized several
//              other modules which contains balancing algorithms and the required calculations. 
//////////////////////////////////////////////////////////////////////////////////

// to run the simulation run the tb_mmc module in simulation sources //

module mmc(
input clk,
input rst,

input signed [31:0] Vc1,
input signed [31:0] Vc2,
input signed [31:0] Vc3,
input signed [31:0] Vc4,
input signed [31:0] Vc5,

input direction,

output [6:0] sine_sample,
output [2:0] M,

output [2:0] rank1,
output [2:0] rank2,
output [2:0] rank3,
output [2:0] rank4,
output [2:0] rank5,

output [4:0] statesf,
 
 output G1,
    output G2,
    output G3,
    output G4,
    output G5

);


wire done;
wire start;

reg [4:0] prev_states;

// Always keep sorter running
assign start = 1'b1;

//--------------------------------------------------
// Sine Generator
//--------------------------------------------------

sin_generator U1(
.clk(clk),
.rst(rst),
.sine_sample(sine_sample)
);

//--------------------------------------------------
// NLM Module
//--------------------------------------------------

nlm_module U2(
.sine_sample(sine_sample),
.M(M)
);

//--------------------------------------------------
// Odd-Even Sorter
//--------------------------------------------------

odd_even_sort5 U3(
.clk(clk),
.rst(rst),
.start(start),
.Vc1(Vc1),
.Vc2(Vc2),
.Vc3(Vc3),
.Vc4(Vc4),
.Vc5(Vc5),

.direction(direction),

.done(done),

.rank1(rank1),
.rank2(rank2),
.rank3(rank3),
.rank4(rank4),
.rank5(rank5)

);


selection_logic U4(
.rank1(rank1),
.rank2(rank2),
.rank3(rank3),
.rank4(rank4),
.rank5(rank5),

.M(M),
.EN(1'b1),

.statesi(prev_states),
.statesf(statesf)

);

assign G1 = statesf[0];
assign G2 = statesf[1];
assign G3 = statesf[2];
assign G4 = statesf[3];
assign G5 = statesf[4];


always @(posedge clk or posedge rst)
begin
if (rst)
prev_states <= 5'b00000;
else
prev_states <= statesf;
end

endmodule     

