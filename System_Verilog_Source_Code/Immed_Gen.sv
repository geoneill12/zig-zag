`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the Immediate Generator module.
//
//
//////////////////////////////////////////////////////////////////////////////////


module Immed_Gen(
    input [31:0] ir,
    output logic [31:0] UType,
    output logic [31:0] IType,
    output logic [31:0] SType,
    output logic [31:0] BType,
    output logic [31:0] JType
    );

always_comb
    begin
    
        UType <= { ir[31:12], 12'b000000000000 };                           // UType 
        IType <= { {20{ir[31]}}, ir[31:20] };                               // IType
        SType <= { {20{ir[31]}}, ir[31:25], ir[11:7] };                     // SType
        BType <= { {20{ir[31]}}, ir[7], ir[30:25], ir[11:8], 1'b0 };        // BType
        JType <= { {12{ir[31]}}, ir[19:12], ir[20], ir[30:21], 1'b0 };      // JType
        
    end

endmodule
