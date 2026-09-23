`timescale 1ns / 1ps

module tb_odd_even_sort5();

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg direction;
    reg [15:0] Vc1, Vc2, Vc3, Vc4, Vc5;

    // Outputs
    wire done;
    wire [2:0] rank1, rank2, rank3, rank4, rank5;

    // Instantiate DUT
    odd_even_sort5 DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .direction(direction),
        .Vc1(Vc1),
        .Vc2(Vc2),
        .Vc3(Vc3),
        .Vc4(Vc4),
        .Vc5(Vc5),
        .done(done),
        .rank1(rank1),
        .rank2(rank2),
        .rank3(rank3),
        .rank4(rank4),
        .rank5(rank5)
    );

    // Clock generation (10 ns period)
    initial
        clk = 0;

    always
        #5 clk = ~clk;

    // Test stimulus
    initial
    begin
        // Initialize
        rst = 1;
        start = 0;
        direction = 1;

        Vc1 = 16'd0;
        Vc2 = 16'd0;
        Vc3 = 16'd0;
        Vc4 = 16'd0;
        Vc5 = 16'd0;

        // Hold reset for 20 ns
        #20;
        rst = 0;

        // Apply test voltages
        Vc1 = 16'd10;   // SM1
        Vc2 = 16'd40;    // SM2
        Vc3 = 16'd60;    // SM3
        Vc4 = 16'd100;    // SM4
        Vc5 = 16'd80;    // SM5

        // Start pulse
        #10;
        start = 1;

        #10;
        start = 0;

        // Run long enough for sorting
        #300;

        $finish;
    end

endmodule