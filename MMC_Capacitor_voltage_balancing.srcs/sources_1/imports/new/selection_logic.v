`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: Gate selection logic
// Module Name: selection_logic
// Tool Versions: vivado 2022.2
// Description: The selection_logic module selects the required submodules 
// to be inserted based on their voltage rankings and the insertion level (`M`).
//  It generates the final switching states while retaining the previous state
//  when the enable signal (`EN`) is low.

//////////////////////////////////////////////////////////////////////////////////


module selection_logic(

// giving ranks as input after sorting // 

    input [2:0] rank1,
    input [2:0] rank2,
    input [2:0] rank3,
    input [2:0] rank4,
    input [2:0] rank5,
// M = number of submodules to be inserted //

    input [2:0] M,
    
// EN = Enable Signal 

    input EN,
 
    input [4:0] statesi, // Previous Switching State //
    output reg [4:0] statesf // final switching pattern //

);

always @(*)
begin

    // Hold previous states
    if (EN == 1'b0)
    begin
        statesf = statesi; // If the controller is disabled, do not change anything.//
                           // Simply copy statesi ? statesf //

    end

    else
    begin

        // Clear all states
        statesf = 5'b00000;

        if (M >= 1)
            statesf[rank1-1] = 1'b1;

        if (M >= 2)
            statesf[rank2-1] = 1'b1;

        if (M >= 3)
            statesf[rank3-1] = 1'b1;

        if (M >= 4)
            statesf[rank4-1] = 1'b1;

        if (M >= 5)
            statesf[rank5-1] = 1'b1;

    end

end

endmodule