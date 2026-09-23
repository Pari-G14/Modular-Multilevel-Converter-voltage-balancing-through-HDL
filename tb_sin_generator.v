`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 17:39:51
// Design Name: 
// Module Name: tb_sin_generator
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


module tb_sin_generator;

    // Inputs
    reg clk;
    reg rst;

    // Output
    wire [6:0] sine_sample;

    // Instantiate DUT
    sin_generator DUT (
        .clk(clk),
        .rst(rst),
        .sine_sample(sine_sample)
    );

    // Generate clock (10 ns period)
    always #5 clk = ~clk;

    initial
    begin
        // Initialize
        clk = 1'b0;
        rst = 1'b1;

        // Hold reset for 20 ns
        #20;
        rst = 1'b0;

        // Run long enough to see several cycles
        #250;

        $finish;
    end

endmodule
