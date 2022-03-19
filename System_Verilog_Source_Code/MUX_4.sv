`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is a general purpose 4:1 Mux, 32-bit inputs and 2-bit select input.
//
//
//////////////////////////////////////////////////////////////////////////////////


module MUX_4(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [31:0] D,
    input [1:0] SEL,
    output logic [31:0] Q
    );

always_comb
    begin
        case(SEL)
            
            0:          Q <= A;
            1:          Q <= B;
            2:          Q <= C;
            3:          Q <= D;
            default:    Q <= 0;
            
        endcase
    end

endmodule
