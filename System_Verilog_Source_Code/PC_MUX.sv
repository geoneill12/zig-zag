`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the input selection MUX for the PC (program counter).
//
// NIS = next instruction
//
//////////////////////////////////////////////////////////////////////////////////


module PC_MUX(
    input [31:0] pc_plus_4,
    input [31:0] jalr,
    input [31:0] branch,
    input [31:0] jal,
    input [31:0] mtvec,
    input [31:0] mepc,
    input [2:0] pcSource,
    output logic [31:0] NIS
    );

always_comb                                     // always_comb block to set the output
    begin
        case(pcSource)
            1:          NIS <= jalr;             // select jalr if pcSource = 1
            2:          NIS <= branch;           // select branch if pcSource = 2
            3:          NIS <= jal;              // select jal if pcSource = 3
            4:          NIS <= mtvec;            // select mtvec if pcSource = 4
            5:          NIS <= mepc;            // select mepc if pcSource = 5
            default:    NIS <= pc_plus_4;        // select pc_plus_4 if pcSource = 0, or by default
        endcase
    end

endmodule
