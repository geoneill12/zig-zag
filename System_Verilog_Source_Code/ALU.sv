`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the ALU module.
//
//
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] alu_fun,
    output logic [31:0] Q
    );

always_comb                                             // always_comb block to set the output
    begin
        case(alu_fun)
            
            4'b0000:    Q <= A + B;                     // addition
            4'b1000:    Q <= A - B;                     // subtraction
            4'b0110:    Q <= A | B;                     // bitwise OR
            4'b0111:    Q <= A & B;                     // bitwise AND
            4'b0100:    Q <= A ^ B;                     // bitwise XOR          
            4'b0101:    Q <= A >> B[4:0];               // srl
            4'b0001:    Q <= A << B[4:0];               // sll
            4'b1101:    Q <= $signed(A) >>> B[4:0];     // sra
            
            4'b0010:                                    // slt
                begin
                    if ( $signed(A) < $signed(B) )
                        Q <= 1;
                    else
                        Q <= 0;
                end
                
            4'b0011:                                    // sltu
                begin
                    if ( A < B)
                        Q <= 1;
                    else
                        Q <= 0;
                end
                
            4'b1001:    Q <= A;                         // lui     
            default:    Q <= 0;                         // default case: set Q to 0
            
        endcase
    end

endmodule
