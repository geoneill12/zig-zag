`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2022 09:07:01 PM
// Design Name: 
// Module Name: vga_driver_80x60
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


module vga_driver_80x60(
    input CLK_25MHz,
    input [2:0] RED,
    input [2:0] GREEN,
    input [1:0] BLUE,
    output logic [9:0] ROW,     // coords of next pixel to be displayed
    output logic [9:0] COLUMN,
    output logic [2:0] ROUT,
    output logic [2:0] GOUT,
    output logic [1:0] BOUT,
    output logic HSYNC,         // horizontal and vertical sync signals
    output logic VSYNC
    );

    const integer HW = 640;                // horizontal columns: 25.17 us
    const integer HF = 22;                 // front porch: 0.94 us
    const integer HS = 93;                 // horizontal sync pulse: 3.77 us
    const integer HB = 45;                 // back porch: 1.89 us
    const integer HC = HW + HF + HS + HB;  // one horizontal sync cycle: 31.77 us
    const integer VW = 480;                // vertical rows: 15.25 ms
    const integer VF = 11;                 // front porch: 0.35 ms
    const integer VS = 2;                  // vertical sync pulse: 64 us
    const integer VB = 32;                 // back porch: 1.02 ms
    const integer VC = VW + VF + VS + VB;  // one vertical sync cycle: 16.6 ms

    logic [9:0] horizontal = '0;  // holds up to HC - 1
    logic [9:0] vertical = '0;    // holds up to VC - 1

    assign ROW = vertical;
    assign COLUMN = horizontal;

    always_ff @(posedge CLK_25MHz) begin

        // define horizontal sync pulse
        if ((horizontal >= (HW + HF)) && (horizontal < (HW + HF + HS))) begin
            HSYNC <= 1'b0;
        end else begin
            HSYNC <= 1'b1;
        end
      
        // define vertical sync pulse
        if ((vertical >= (VW + VF)) && (vertical < (VW + VF + VS))) begin
            VSYNC <= 1'b0;
        end else begin
            VSYNC <= 1'b1;
        end
        
        // if in valid range displayed on screen, output pixel color data
        if ((horizontal < HW) && (vertical < VW)) begin
            ROUT <= RED;
            GOUT <= GREEN;
            BOUT <= BLUE;
        end else begin
            ROUT <= 3'b000;
            GOUT <= 3'b000;
            BOUT <= 2'b00;
        end
     
        // update counters
        if (horizontal < HC - 1) begin
            horizontal <= horizontal + 1;
        end else begin
            horizontal <= '0;
            if (vertical < VC - 1) begin
                vertical <= vertical + 1;
            end else begin
                vertical <= '0;
            end
        end

    end

endmodule