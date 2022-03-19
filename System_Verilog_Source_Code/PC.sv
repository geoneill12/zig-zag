`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the program counter register. It stores the value of the currently executing instruction.
//
// NIS = next instruction
// CIS = current instruction
//
//////////////////////////////////////////////////////////////////////////////////


module PC(
    input clk,
    input [31:0] NIS,
    input reset,
    input pcWrite,
    output logic [31:0] CIS
    );

logic [31:0] mem = 0;                   // register for storing the CIS

//initial
//    begin
//        mem = 0;
//    end

always_comb                        // always sends the CIS to the output
    begin
        CIS <= mem;
    end

always_ff @ (posedge clk)           // always re-evaluates the PC at the positive edge of the clk
    begin
    
        if (reset == 1)             // if reset = 1, reset mem to 0
            begin
                mem <= 'h00000000;
            end
        
        else if (pcWrite == 1)                        // else, if pcWrite is 1, save NIS to mem
            begin
                mem <= NIS;
            end
    
    end

endmodule
