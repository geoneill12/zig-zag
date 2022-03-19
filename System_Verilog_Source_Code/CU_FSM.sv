`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the CU_FSM module.
//
//
//////////////////////////////////////////////////////////////////////////////////


module CU_FSM(
    input clk,
    input RST,
    input INTR,
    input [31:0] ir,
    output logic pcWrite = 0,
    output logic regWrite = 0,
    output logic memWrite = 0,
    output logic memRead1 = 1,
    output logic memRead2 = 0,
    output logic csrWrite = 0,
    output logic intTaken = 0
    );

logic [1:0] S0, S1, S2, S3, NS;             // define states for FSM
logic [1:0] PS = 0;
assign S0 = 2'b00;
assign S1 = 2'b01;
assign S2 = 2'b10;
assign S3 = 2'b11;

logic [6:0] BRANCH, LOAD, STORE, CSRRW;        // logic for instruction type
assign BRANCH = 7'b1100011;
assign LOAD = 7'b0000011;
assign STORE = 7'b0100011;
assign CSRRW = 7'b1110011;

always_ff @ (posedge clk)               // always_ff block to evaluate the next state
    begin
        if ( RST == 1 )
            PS = 0;
        else
            PS = NS;
    end

always_comb
    begin
        case(PS)
            
            S0:                             // fetch state
                begin
                        pcWrite = 0;
                        regWrite = 0;
                        memWrite = 0;
                        memRead1 = 1;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        NS = S1;
                end
                
///////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            S1:                             // execute state
                begin
                
                if ( ir[6:0] == LOAD )   // load instruction
                    begin
                        pcWrite = 0;
                        regWrite = 0;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 1;
                        csrWrite = 0;
                        intTaken = 0;
                        if ( INTR == 1 )
                            NS = S3;
                        else
                            NS = S2;
                    end
                else if ( ir[6:0] == BRANCH )                        // branch instruction
                    begin
                        pcWrite = 1;
                        regWrite = 0;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        if ( INTR == 1)
                            NS = S3;
                        else
                            NS = S0;
                    end
                else if ( ir[6:0] == STORE )                        // store instruction
                    begin
                        pcWrite = 1;
                        regWrite = 0;
                        memWrite = 1;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        if ( INTR == 1)
                            NS = S3;
                        else
                            NS = S0;
                    end
                else if ( ir[6:0] == CSRRW )                        // csrrw instruction
                    begin
                        pcWrite = 1;
                        regWrite = 1;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 1;
                        intTaken = 0;
                        if ( INTR == 1)
                            NS = S3;
                        else
                            NS = S0;
                    end
                else                                                // all other instructions
                    begin
                        pcWrite = 1;
                        regWrite = 1;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        if ( INTR == 1)
                            NS = S3;
                        else
                            NS = S0;
                    end
                end

///////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            S2:                             // write_back state (load)
                begin
                        pcWrite = 1;
                        regWrite = 1;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        if ( INTR == 1)
                            NS = S3;
                        else
                            NS = S0;
                end

///////////////////////////////////////////////////////////////////////////////////////////////////////////

            S3:                             // interrupt state
                begin
                        pcWrite = 1;
                        regWrite = 0;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 1;
                        NS = S0;
                end

///////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            default:                        // default state to prevent latches
                begin
                        pcWrite = 0;
                        regWrite = 0;
                        memWrite = 0;
                        memRead1 = 0;
                        memRead2 = 0;
                        csrWrite = 0;
                        intTaken = 0;
                        NS = S0;
                end
            
        endcase
    end

endmodule