`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2022 09:08:24 PM
// Design Name: 
// Module Name: ram8k_8_80x60
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ram8k_8_80x60(
    input CLK_50MHz,
    input WE,           // write enable
    input [12:0] WA1,   // write address 1
    input [12:0] RA2,   // read address 2
    input [7:0] WD,     // write data to address 1
    output [7:0] RD1,   // read data from address 1
    output [7:0] RD2    // read data from address 2
    );
    
    logic [7:0] r_memory [7631:0];  // 128 * 60 - (128 - 80)
    
    // Initialize all memory to 0s
    initial begin
        int i;
        for (i = 0; i < 7632; i++) begin
            r_memory[i] = 8'h00;
        end
    end
    
    // only save data on rising edge
    always_ff @(posedge CLK_50MHz) begin
        if (WE) begin
            r_memory[WA1] <= WD;
        end
    end
    
    assign RD2 = r_memory[RA2];
    assign RD1 = r_memory[WA1];
    
endmodule