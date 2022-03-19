`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the Register Memory module.
//
//
//////////////////////////////////////////////////////////////////////////////////


module Reg_File(
    input [4:0] adr1,
    input [4:0] adr2,
    input [31:0] wd,
    input [4:0] wa,
    input en,
    input clk,
    output logic [31:0] rs1,
    output logic [31:0] rs2
    );

logic [31:0] mem [0:31];
       
assign rs1 = mem[adr1];
assign rs2 = mem[adr2];

initial
    begin
        int i;
        for (i=0; i<32; i++)
            begin
                mem[i] = 0;
            end
    end

always_ff @ (posedge clk)
    begin
        
        if ( (en == 1) && (wa != 0) )
            begin
                mem[wa] <= wd;
            end
        
    end

endmodule
