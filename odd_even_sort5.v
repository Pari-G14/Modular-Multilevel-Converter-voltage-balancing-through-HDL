`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: odd_even sorter
// Module Name: odd_even_sort5
// Tool Versions: vivado 2022.2
// Description: this module contains the sorting algorithms we have used one of the
//              most efficient sorting algorithm called odd even sorter which sorts the 
//              different capacitors voltages and sorts them in ascending or descending 
//              order depending on the current. we have also initialized compare swap module 
//              in this module.                                                                                                                                                                                                                                                                                                                                                                                       
//////////////////////////////////////////////////////////////////////////////////


module odd_even_sort5(
////////////////// inputs///////////////
    input clk,
    input rst,
    input start,

input signed [31:0] Vc1,
input signed [31:0] Vc2,
input signed [31:0] Vc3,
input signed [31:0] Vc4,
input signed [31:0] Vc5,

    input direction, // Determines sorting order.This depends on the arm current direction in the MMC.//

////////////// done=0, done=1 after 5 phases///////////////

    output reg done,
    
    ///////////////// output //////////////

    output reg [2:0] rank1,
    output reg [2:0] rank2,
    output reg [2:0] rank3,
    output reg [2:0] rank4,
    output reg [2:0] rank5
);
////////////// storage registers ////////////////////
reg [31:0] V [0:4];
reg [2:0] ID [0:4];

//////////////////////// FSM ///////////////////////////// 
//Defines four FSM states.
// IDLE: Waiting for start.
// LOAD: Loads input voltages into internal registers.
// SORTl: Performs odd-even sorting.
// DONE: Outputs the final ranks.

reg [1:0] state;

localparam IDLE = 2'd0, 
           LOAD = 2'd1,
           SORT = 2'd2,
           DONE = 2'd3;
           
reg [1:0] state;
reg phase;                // 0=Odd, 1=Even
reg [2:0] phase_count;

/////////////// wires for comparator inputs///////////////////


wire [31:0] csa_v1, csa_v2;
wire [31:0] csb_v1, csb_v2;

wire [2:0] csa_id1, csa_id2;
wire [2:0] csb_id1, csb_id2;

/////////// conditions //////////
 
 assign csa_v1 = (phase == 0)? V[0]:V[1];
 assign csa_v2 = (phase == 0)? V[1]:V[2];
 
 assign csa_id1 = (phase == 0)? ID[0]:ID[1];
 assign csa_id2 = (phase == 0)? ID[1]:ID[2];
 
 assign csb_v1 = (phase == 0)? V[2]:V[3];
 assign csb_v2 = (phase == 0)? V[3]:V[4];
 
 assign csb_id1 = (phase == 0)? ID[2]:ID[3];
 assign csb_id2 = (phase == 0)? ID[3]:ID[4];
 
 ///////////////COMPARATOR OUTPUTS////////////
 
 
wire [31:0] csa_out1_v;
wire [31:0] csa_out2_v;
wire [31:0] csb_out1_v;
wire [31:0] csb_out2_v;

wire [2:0] csa_out1_id;
wire [2:0] csa_out2_id;
wire [2:0] csb_out1_id;
wire [2:0] csb_out2_id;
 
/////////////// initiating compare_swap ///////////

compare_swap CSA(
    .V1(csa_v1),
    .V2(csa_v2),
    .ID1(csa_id1),
    .ID2(csa_id2),
    .direction(direction),

    .out1_v(csa_out1_v),
    .out2_v(csa_out2_v),
    .out1_id(csa_out1_id),
    .out2_id(csa_out2_id)
);
 
compare_swap CSB(
    .V1(csb_v1),
    .V2(csb_v2),
    .ID1(csb_id1),
    .ID2(csb_id2),
    .direction(direction),

    .out1_v(csb_out1_v),
    .out2_v(csb_out2_v),
    .out1_id(csb_out1_id),
    .out2_id(csb_out2_id)
);
/////////////////////// FSM ///////////////////////////

always @(posedge clk or posedge rst)
begin

    if (rst) // Returns the sorter to its initial condition. //
    begin
        state <= IDLE; // Returns FSM to IDLE. //
        phase <= 0;    // Starts with the odd comparison phase //
        phase_count <= 0;
        done <= 0;
        
    rank1 <= 0;
    rank2 <= 0;
    rank3 <= 0;
    rank4 <= 0;
    rank5 <= 0;
    end

    else
    begin

        case(state)
        
        IDLE:
       begin
       done <= 1'b0;
       if (start)
       state <= LOAD;
       end     
     
     LOAD:
      begin
      
      V[0] <= Vc1;
      V[1] <= Vc2;
      V[2] <= Vc3;
      V[3] <= Vc4;
      V[4] <= Vc5;
      
      ID[0] <= 3'd1;
      ID[1] <= 3'd2;
      ID[2] <= 3'd3;
      ID[3] <= 3'd4;
      ID[4] <= 3'd5;
     
     phase <= 1'b0;
     phase_count <= 3'b0;
     
     state <= SORT;
     end  
     
  
        SORT:
        begin

            if (phase == 1'b0)
            begin
                // Odd phase
                V[0] <= csa_out1_v;
                ID[0] <= csa_out1_id;

                V[1] <= csa_out2_v;
                ID[1] <= csa_out2_id;

                V[2] <= csb_out1_v;
                ID[2] <= csb_out1_id;

                V[3] <= csb_out2_v;
                ID[3] <= csb_out2_id;
            end
            else
            begin
                // Even phase
                V[1] <= csa_out1_v;
                ID[1] <= csa_out1_id;

                V[2] <= csa_out2_v;
                ID[2] <= csa_out2_id;

                V[3] <= csb_out1_v;
                ID[3] <= csb_out1_id;

                V[4] <= csb_out2_v;
                ID[4] <= csb_out2_id;
            end

            if (phase_count == 3'd4)
                state <= DONE;

            phase_count <= phase_count + 1'b1;
            phase <= ~phase;

        end
 
  DONE:
        begin
            rank1 <= ID[0];
            rank2 <= ID[1];
            rank3 <= ID[2];
            rank4 <= ID[3];
            rank5 <= ID[4];

            done <= 1'b1;

            state <= IDLE;
        end

        endcase

    end

end  

endmodule
