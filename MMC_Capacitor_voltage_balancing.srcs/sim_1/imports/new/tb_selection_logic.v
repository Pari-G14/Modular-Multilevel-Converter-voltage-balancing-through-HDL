`timescale 1ns / 1ps

module tb_selection_logic;

    // Inputs
    reg [2:0] rank1;
    reg [2:0] rank2;
    reg [2:0] rank3;
    reg [2:0] rank4;
    reg [2:0] rank5;
    reg [2:0] M;
    reg EN;
    reg [4:0] statesi;

    // Output
    wire [4:0] statesf;

    // Instantiate DUT
    selection_logic DUT (
        .rank1(rank1),
        .rank2(rank2),
        .rank3(rank3),
        .rank4(rank4),
        .rank5(rank5),
        .M(M),
        .EN(EN),
        .statesi(statesi),
        .statesf(statesf)
    );

    initial
    begin

        // Example sorted ranks:
        // rank1 = SM4
        // rank2 = SM2
        // rank3 = SM3
        // rank4 = SM5
        // rank5 = SM1

        rank1 = 3'd4;
        rank2 = 3'd2;
        rank3 = 3'd3;
        rank4 = 3'd5;
        rank5 = 3'd1;

        //------------------------------------------------
        // Test Case 1 : M = 3, EN = 1
        //------------------------------------------------
        EN = 1'b1;
        M = 3'd3;
        statesi = 5'b00000;

        #20;
        // Expected statesf = 01110

        //------------------------------------------------
        // Test Case 2 : M = 2, EN = 1
        //------------------------------------------------
        M = 3'd2;

        #20;
        M = 3'd5;

        #20;
        // Expected statesf = 11111

        //------------------------------------------------
        // Test Case 4 : EN = 0 (Hold previous state)
        //------------------------------------------------
        EN = 1'b0;
        statesi = 5'b10101;

        #20;
        
        $finish;

    end

endmodule