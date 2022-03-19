`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
// This module is the Control Unit Decoder module. This module configures all the datapaths needed
// for the current instruction.
//
//
//////////////////////////////////////////////////////////////////////////////////


module CU_Decoder(
    input br_eq,
    input br_lt,
    input br_ltu,
    input [31:0] ir,
    input intTaken,
    output logic [3:0] alu_fun,
    output logic alu_srcA,
    output logic [1:0] alu_srcB,
    output logic [2:0] pcSource,
    output logic [1:0] rf_wr_sel
    );

logic [9:0] instr_code;
assign instr_code = {ir[14:12], ir[6:0]};

always_comb
    begin
        
        if ( intTaken == 1 )
            begin
                
                alu_fun = 0;
                alu_srcA = 0;
                alu_srcB = 0;
                pcSource = 4;
                rf_wr_sel = 0;
        
            end
        else
        begin
        
        case(instr_code)
            
            10'b0001100111:                                     // jalr
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 1;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0001100011:                                     // beq
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_eq == 1 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0011100011:                                     // bne
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_eq == 0 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b1001100011:                                     // blt
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_lt == 1 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b1011100011:                                     // bge
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_lt == 0 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b1101100011:                                     // bltu
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_ltu == 1 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b1111100011:                                     // bgeu
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        if ( br_ltu == 0 )
                                            pcSource = 2;
                                        else
                                            pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0000000011:                                     // lb
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 2;
                                end
                                
            10'b0010000011:                                     // lh
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 2;
                                end
                                
            10'b0100000011:                                     // lw
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 2;
                                end
                                
            10'b1000000011:                                     // lbu
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 2;
                                end
                                
            10'b1010000011:                                     // lhu
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 2;
                                end
                                
            10'b0000100011:                                     // sb
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 2;
                                        pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0010100011:                                     // sh
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 2;
                                        pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0100100011:                                     // sw
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 2;
                                        pcSource = 0;
                                        rf_wr_sel = 0;
                                end
                                
            10'b0000010011:                                     // addi
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b0100010011:                                     // slti
                                begin
                                        alu_fun = 4'b0010;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b0110010011:                                     // sltiu
                                begin
                                        alu_fun = 4'b0011;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1000010011:                                     // xori
                                begin
                                        alu_fun = 4'b0100;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1100010011:                                     // ori
                                begin
                                        alu_fun = 4'b0110;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1110010011:                                     // andi
                                begin
                                        alu_fun = 4'b0111;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b0010010011:                                     // slli
                                begin
                                        alu_fun = 4'b0001;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1010010011:                                     // srli & srai
                                begin
                                if ( ir[30] == 0)               // srli
                                begin
                                        alu_fun = 4'b0101;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                else                            // srai
                                begin
                                        alu_fun = 4'b1101;
                                        alu_srcA = 0;
                                        alu_srcB = 1;
                                        pcSource = 0;
                                        rf_wr_sel = 3; 
                                end
                                end
                                
            10'b0000110011:                                     // add & sub
                                begin
                                if ( ir[30] == 0)               // add
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                else                            // sub
                                begin
                                        alu_fun = 4'b1000;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3; 
                                end
                                end
                                
            10'b0010110011:                                     // sll
                                begin
                                        alu_fun = 4'b0001;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b0100110011:                                     // slt
                                begin
                                        alu_fun = 4'b0010;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b0110110011:                                     // sltu
                                begin
                                        alu_fun = 4'b0011;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1000110011:                                     // xor
                                begin
                                        alu_fun = 4'b0100;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1010110011:                                     // srl & sra
                                begin
                                if ( ir[30] == 0)               // srl
                                begin
                                        alu_fun = 4'b0101;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                else                            // sra
                                begin
                                        alu_fun = 4'b1101;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3; 
                                end
                                end
                                
            10'b1100110011:                                     // or
                                begin
                                        alu_fun = 4'b0110;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
            10'b1110110011:                                     // and
                                begin
                                        alu_fun = 4'b0111;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
            
            10'b0011110011:                                     // csrrw
                                begin
                                        alu_fun = 4'b1001;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 1;
                                end
            
            10'b0001110011:                                     // mret
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 5;
                                        rf_wr_sel = 0;
                                end
                                
            default:
                begin
                    if      ( instr_code[6:0] == 7'b0110111 )   // lui
                                begin
                                        alu_fun = 4'b1001;
                                        alu_srcA = 1;
                                        alu_srcB = 0;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
                    
                    else if ( instr_code[6:0] == 7'b0010111 ) // auipc
                                begin
                                        alu_fun = 4'b0000;
                                        alu_srcA = 1;
                                        alu_srcB = 3;
                                        pcSource = 0;
                                        rf_wr_sel = 3;
                                end
                                
                    
                    else                                      // jal
                                begin
                                        alu_fun = 0;
                                        alu_srcA = 0;
                                        alu_srcB = 0;
                                        pcSource = 3;
                                        rf_wr_sel = 0;
                                end
                                
                end
            
        endcase
        end
        
    end

endmodule
