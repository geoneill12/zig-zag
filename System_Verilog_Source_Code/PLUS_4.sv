`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module adds decimal value 4 to the current PC value.
//
// CIS = current instruction
//
// NIS = next instruction
//
//////////////////////////////////////////////////////////////////////////////////


module PLUS_4(
    input [31:0] CIS,
    output logic [31:0] NIS
    );

logic [31:0] t0;
assign t0 = 'h00000004;         // continuously assign decimal value 4 to variable t0

always_comb
    begin
    
        NIS <= CIS + t0;        // always add t0 to CIS, assign result to NIS
    
    end

endmodule
