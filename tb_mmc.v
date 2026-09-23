`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.06.2026 11:25:04
// Created by: Pari Gupta
// Project Name: testbench mmc
// Module Name: tb_mmc
// Tool Versions: vivado 2022.2
// Description: testbench for the top module 
//////////////////////////////////////////////////////////////////////////////////


/* WARNING Run Simulation and then in TCL console give command "Run 5 ms" and press enter 
 to rerun the simulation the simulated waveform is the required waveform the simulation
 needs more time to run the balancing code and to show results*/
 
 
/* WARNING this code contains file open function which reads the voltages from a .txt
file the code contains the file location. to run code in your device kindly change the
file location to a new location where the .txt frile is vaed in your device*/


module tb_mmc;
    reg clk;
    reg rst;

    reg [31:0] Vc1;
    reg [31:0] Vc2;
    reg [31:0] Vc3;
    reg [31:0] Vc4;
    reg [31:0] Vc5;

    reg direction;

    wire [6:0] sine_sample;
    wire [2:0] M;

    wire [2:0] rank1;
    wire [2:0] rank2;
    wire [2:0] rank3;
    wire [2:0] rank4;
    wire [2:0] rank5;

    wire [4:0] statesf;

    wire G1;
    wire G2;
    wire G3;
    wire G4;
    wire G5;

    integer file;
    integer total_samples;
    integer status;
    integer i;

   
    mmc DUT
    (
        .clk(clk),
        .rst(rst),

        .Vc1(Vc1),
        .Vc2(Vc2),
        .Vc3(Vc3),
        .Vc4(Vc4),
        .Vc5(Vc5),

        .direction(direction),

        .sine_sample(sine_sample),
        .M(M),

        .rank1(rank1),
        .rank2(rank2),
        .rank3(rank3),
        .rank4(rank4),
        .rank5(rank5),

        .statesf(statesf),

        .G1(G1),
        .G2(G2),
        .G3(G3),
        .G4(G4),
        .G5(G5)
    );

    //--------------------------------------------------
    // 100 MHz Clock
    //--------------------------------------------------
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end

   
    initial
    begin

        rst = 1;
        direction = 1'b1;

        Vc1 = 0;
        Vc2 = 0;
        Vc3 = 0;
        Vc4 = 0;
        Vc5 = 0;

        #20;
        rst = 0;

        
      file = $fopen("C:/Users/parig/Downloads/Vc_data_fixed_ascii.txt","r");
      
        if(file == 0)
        begin
            $display("ERROR : Cannot open Vc_data.txt");
            $finish;
        end

        $display("MATLAB waveform file opened successfully!");

       
        status = $fscanf(file,"%d\n",total_samples);

        $display("Total Samples = %d",total_samples);

       
       
        for(i=0;i<total_samples;i=i+1)
        begin

       status = $fscanf(
       file,
       "%d %d %d %d %d\n",
    Vc1,
    Vc2,
    Vc3,
    Vc4,
    Vc5
);
            if(status != 5)
            begin
                $display("Reached End of File.");
                $finish;
            end

           
            $display("Sample %0d : %0d %0d %0d %0d %0d",
                     i,Vc1,Vc2,Vc3,Vc4,Vc5);

            #50000;

        end

     
        $fclose(file);

        $display("Simulation Finished.");

        #100;

        $finish;

    end

endmodule