`timescale 1ns / 1ps

module tb_nlm_module;

    reg  [6:0] sine_sample;
    wire [2:0] M;

    // Instantiate DUT (Device Under Test)
    nlm_module uut (
        .sine_sample(sine_sample),
        .M(M));

    initial begin

        sine_sample = 0;     #10;
        sine_sample = 25;    #10;
        sine_sample = 50;    #10;
        sine_sample = 74;    #10;
        sine_sample = 95;    #10;
        sine_sample = 100;   #10;

        #10;
        $finish;

    end

endmodule