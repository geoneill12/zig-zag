`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: J. Calllenes
//           P. Hummel
// 
// Create Date: 01/20/2019 10:36:50 AM
// Description: OTTER Wrapper (with Debounce, Switches, LEDS, and SSEG
//////////////////////////////////////////////////////////////////////////////////

module OTTER_Wrapper(
   input    CLK_100MHz,
   input    BTNL,
   input    BTNR,
   input    BTNU,
   input    BTND,
   input    BTNC,
   input    [15:0] SWITCHES,
   output   logic [15:0] LEDS,
   output   [7:0] CATHODES,
   output   [3:0] ANODES,
   output   [7:0] VGA_RGB,
   output   VGA_HS,
   output   VGA_VS
   );


/********** MMI (memory mapped input) addresses **********/

localparam SWITCHES_AD =    32'h11000000;
localparam VGA_READ_AD =    32'h11040000;
localparam BUTTONS_AD =     32'h11180000;

/********** MMO (memory mapped output) addresses **********/

localparam LEDS_AD =        32'h11080000;
localparam SSEG_AD =        32'h110C0000;
localparam VGA_ADDR_AD =    32'h11100000;
localparam VGA_COLOR_AD =   32'h11140000;

/********** Signals for connecting OTTERMCU to OTTER_wrapper **********/

logic   btn_rst, btn_int, sclk;
logic   [15:0]  r_SSEG;
logic   [31:0] IOBUS_out,IOBUS_in,IOBUS_addr;
logic   IOBUS_wr;
logic   CLK_50MHz = 0;
assign btn_rst = ( BTNL & BTNC & BTNR );

/********** Signals for VGA Driver **********/

logic   r_vga_we;
logic   [12:0] r_vga_wa;
logic   [7:0] r_vga_wd;
logic   [7:0] r_vga_rd;

/********** Signals for buttons **********/
logic [3:0] buttons;
assign buttons[0] = BTNL;
assign buttons[1] = BTNR;
assign buttons[2] = BTNU;
assign buttons[3] = BTND;

/********** Module Instantiations **********/

// OTTER
OTTERMCU    MCU     ( .RST(btn_rst),
                        .INTR(btn_int),
                        .CLK(CLK_50MHz),
                        .IOBUS_OUT(IOBUS_out),
                        .IOBUS_IN(IOBUS_in),
                        .IOBUS_ADDR(IOBUS_addr),
                        .IOBUS_WR(IOBUS_wr) );

// Seven Segment Display
SevSegDisp  SSG_DISP    ( .DATA_IN(r_SSEG),
                            .CLK(CLK_100MHz),
                            .MODE(1'b0),
                            .CATHODES(CATHODES),
                            .ANODES(ANODES) );

// One Shot Debouncer for the interrupt button
debounce_one_shot   DBint   ( .CLK(CLK_50MHz),
                                .BTN(BTNL),
                                .DB_BTN(btn_int) );

// VGA Driver
vga_fb_driver_80x60 VGA     ( .CLK_50MHz(CLK_50MHz),
                                .WA(r_vga_wa),
                                .WD(r_vga_wd),
                                .WE(r_vga_we),
                                .RD(r_vga_rd),
                                .ROUT(VGA_RGB[7:5]),
                                .GOUT(VGA_RGB[4:2]),
                                .BOUT(VGA_RGB[1:0]),
                                .HS(VGA_HS),
                                .VS(VGA_VS) );

always_ff @ (posedge CLK_100MHz)    // BLOCK NAME: CLK_DIV
    begin
        CLK_50MHz <= ~CLK_50MHz;
    end
/*
    BLOCK NAME:
    
        CLK_DIV
        
    FUNCTION:
    
        Reduced the CLK frequency by a factor of 2.
        
    DESCRIPTION:
    
        The input port is connected to the Wrapper-level CLK signal. On the rising edge of this CLK signal, it toggles
        the output CLK signal, effectively dividing the frequency by 2.
*/

/********** Connect Board peripherals (Memory Mapped IO devices) to IOBUS **********/

always_ff @ (posedge CLK_50MHz)      // BLOCK NAME: MMO
begin
    r_vga_we <= 0;
    if(IOBUS_wr)
        begin
        case(IOBUS_addr)
        
            LEDS_AD:        LEDS        <= IOBUS_out;
            SSEG_AD:        r_SSEG      <= IOBUS_out[15:0];
            VGA_ADDR_AD:    r_vga_wa    <= IOBUS_out[12:0];
            VGA_COLOR_AD:
            begin
                            r_vga_wd    <= IOBUS_out[7:0];
                            r_vga_we    <= 1;
            end
            
        endcase
        end
end
/*
    BLOCK NAME:
    
        MMO
    
    FUNCTION:
    
        Passes data from OTTER to MMO; either the LEDs or the Seven Segment Display.
        
    DESCRIPTION:
    
        During a store instruction, IOBUS_wr is set high, IOBUS_addr is set to the address the instruction wants to write to, and
        IOBUS_out contains the data that is to be written to that address. Whenever IOBUS_wr is set high, IOBUS_addr is re-evaluated.
        If IOBUS_addr is equal to the MMO address for the LEDs, then IOBUS_out is loaded to that address. If IOBUS_addr is equal
        to the MMO address for the Seven Segment Display, then IOBUS_out is loaded to that address instead.
*/

always_comb     // BLOCK NAME: MMI
begin
    IOBUS_in=32'b0;
    case(IOBUS_addr)
    
        SWITCHES_AD:    IOBUS_in[15:0]  = SWITCHES;
        VGA_READ_AD:    IOBUS_in[7:0]   = r_vga_rd;
        BUTTONS_AD:     IOBUS_in[3:0]   = buttons;
        default:        IOBUS_in        = 32'b0;
        
    endcase
end
endmodule
/*
    BLOCK NAME:
    
        MMI
    
    FUNCTION:
    
        Passes data from MMI to OTTER; the only MMI are the Switches.
    
    DESCRIPTION:
    
        During a load instruction, IOBUS_addr is set equal to the address that the instruction wants to load from.
        If IOBUS_addr is equal to SWITCHES_AD, then the value of SWITCHES is passed into IOBUS_in so
        that the OTTER can access it. Otherwise, IOBUS_in is set to 0.
*/