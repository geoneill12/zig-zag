`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the Target Generator module.
//
//
//////////////////////////////////////////////////////////////////////////////////


module Target_Gen(
    input [31:0] CIS,
    input [31:0] IType,
    input [31:0] BType,
    input [31:0] JType,
    input [31:0] rs1,
    output logic [31:0] jalr,
    output logic [31:0] branch,
    output logic [31:0] jal
    );

always_comb
    begin
        
        jalr <= rs1 + IType;            // jalr immediate
        branch <= CIS + BType;          // branch immediate
        jal <= CIS + JType;             //jal immediate
        
    end

endmodule
