`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the Branch Conditional Generator. It indicates whether the 2 inputs
// are equal, if R1 < R2 (signed), or if R1 < R2 (unsigned).
//
//
//////////////////////////////////////////////////////////////////////////////////


module Branch_CondGen(
    input [31:0] rs1,
    input [31:0] rs2,
    output logic br_eq,
    output logic br_lt,
    output logic br_ltu
    );

always_comb
    begin
        
        if ( rs1 == rs2 )
                br_eq <= 1;
        else
                br_eq <= 0;
        
    end

always_comb
    begin
        
        if ( $signed(rs1) < $signed(rs2) )
                br_lt <= 1;  
        else
                br_lt <= 0;
        
    end

always_comb
    begin
        
        if ( rs1 < rs2 )
                br_ltu <= 1;
         else
                br_ltu <= 0;
        
    end

endmodule
