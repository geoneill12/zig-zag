/*
	Coordinates are given in row major format: (col,row) = (x,y)
	X-coordinate range: 0-79
	Y-coordinate range: 0-59
	Color range is from 0x00 to 0xFF
*/

const int BG_COLOR = 0x17;  // light blue (0/7 red, 3/7 green, 3/3 blue)
volatile int * const VG_ADDR = (int *)0x11100000;
volatile int * const VG_COLOR = (int *)0x11140000;
volatile int * const SSD = (int *)0x110C0000;
volatile int * const  LEDS = (int *)0x11080000;
volatile int * const SWITCHES = (int*)0x11000000;
volatile int * const BUTTONS = (int*)0x11180000;
static void draw_dot(int X, int Y, int color);
static void draw_horizontal_line(int X, int Y, int toX, int color);
static void draw_vertical_line(int X, int Y, int toY, int color);
static void draw_background();

void main() {

	/********** Variable declarations **********/
	const int COLOR = 0x00;
	const int WALL_COLOR = 0x9D;
	const int FOOD_COLOR = 0x60;
	int XCOR = 0;
	int YCOR = 0;
	int old_XCOR = 0;
	int old_YCOR = 0;
	int XDIR = 1;
	int YDIR = 1;
	int FLAG;
	int buttons;
	int MAX_COUNT;

	/********** Initialize background **********/
	draw_background();
	draw_vertical_line(10,10,49,WALL_COLOR);
	draw_vertical_line(68,10,49,WALL_COLOR);
	draw_vertical_line(34,0,10,WALL_COLOR);
	draw_vertical_line(45,0,10,WALL_COLOR);
	draw_vertical_line(34,49,59,WALL_COLOR);
	draw_vertical_line(45,49,59,WALL_COLOR);
	draw_vertical_line(39,24,35,WALL_COLOR);
	draw_vertical_line(40,24,35,WALL_COLOR);

	draw_horizontal_line(34,29,45,WALL_COLOR);
	draw_horizontal_line(34,30,45,WALL_COLOR);
	draw_horizontal_line(19,10,34,WALL_COLOR);
	draw_horizontal_line(19,49,34,WALL_COLOR);
	draw_horizontal_line(45,10,59,WALL_COLOR);
	draw_horizontal_line(45,49,59,WALL_COLOR);

	draw_dot( 39, 6, FOOD_COLOR );
	draw_dot( 40, 6, FOOD_COLOR );
	draw_dot( 42, 56, FOOD_COLOR );
	draw_dot( 47, 37, FOOD_COLOR );
	draw_dot( 48, 17, FOOD_COLOR );
	draw_dot( 49, 17, FOOD_COLOR );
	draw_dot( 53, 26, FOOD_COLOR );
	draw_dot( 53, 27, FOOD_COLOR );
	draw_dot( 56, 44, FOOD_COLOR );
	draw_dot( 56, 45, FOOD_COLOR );
	draw_dot( 57, 44, FOOD_COLOR );
	draw_dot( 57, 45, FOOD_COLOR );
	draw_dot( 60, 36, FOOD_COLOR );
	draw_dot( 60, 18, FOOD_COLOR );
	draw_dot( 1, 13, FOOD_COLOR );
	draw_dot( 6, 23, FOOD_COLOR );
	draw_dot( 2, 39, FOOD_COLOR );
	draw_dot( 5, 53, FOOD_COLOR );
	draw_dot( 5, 54, FOOD_COLOR );
	draw_dot( 6, 54, FOOD_COLOR );
	draw_dot( 19, 56, FOOD_COLOR );
	draw_dot( 30, 52, FOOD_COLOR );
	draw_dot( 19, 5, FOOD_COLOR );
	draw_dot( 21, 3, FOOD_COLOR );
	draw_dot( 16, 1, FOOD_COLOR );
	draw_dot( 7, 1, FOOD_COLOR );
	draw_dot( 16, 2, FOOD_COLOR );
	draw_dot( 51, 2, FOOD_COLOR );
	draw_dot( 56, 6, FOOD_COLOR );
	draw_dot( 64, 2, FOOD_COLOR );
	draw_dot( 65, 2, FOOD_COLOR );
	draw_dot( 65, 3, FOOD_COLOR );
	draw_dot( 75, 4, FOOD_COLOR );
	draw_dot( 71, 24, FOOD_COLOR );
	draw_dot( 72, 24, FOOD_COLOR );
	draw_dot( 76, 41, FOOD_COLOR );
	draw_dot( 74, 55, FOOD_COLOR );
	draw_dot( 57, 56, FOOD_COLOR );
	draw_dot( 56, 56, FOOD_COLOR );
	draw_dot( 15, 30, FOOD_COLOR );
	draw_dot( 18, 43, FOOD_COLOR );
	draw_dot( 19, 17, FOOD_COLOR );
	draw_dot( 23, 26, FOOD_COLOR );
	draw_dot( 23, 27, FOOD_COLOR );
	draw_dot( 24, 26, FOOD_COLOR );
	draw_dot( 24, 27, FOOD_COLOR );
	draw_dot( 30, 40, FOOD_COLOR );
	draw_dot( 30, 15, FOOD_COLOR );
	draw_dot( 30, 16, FOOD_COLOR );
	draw_dot( 31, 15, FOOD_COLOR );
	draw_dot( 31, 16, FOOD_COLOR );
	draw_dot( 35, 23, FOOD_COLOR );
	draw_dot( 38, 45, FOOD_COLOR );
	draw_dot( 39, 45, FOOD_COLOR );
	
	while (1) {
		
		/********** Draw dot **********/
		draw_dot( XCOR, YCOR, COLOR );

		/********** Fill in previous dot location with background color **********/
		draw_dot( old_XCOR, old_YCOR, BG_COLOR );

		/********** A "for loop" to slow down the frame rate, and to read button inputs  **********/
		MAX_COUNT = (*SWITCHES)*10000;
		FLAG = 0;
		buttons = 0;
		for ( int TIMER = 0; TIMER < MAX_COUNT; TIMER++ ) {
			if ( FLAG == 0 ) {
				buttons = *BUTTONS;
				if ( buttons > 0 ) {
					FLAG = 1;
				}
			}
		}


		/********** Adjust X and Y directions based on button inputs **********/
		if ( buttons == 1 ) {
			XDIR = -1;
			YDIR = 0;
		}
		if (buttons == 5 ) {
			XDIR = -1;
			YDIR = -1;
		}
		if (buttons == 4 ) {
			XDIR = 0;
			YDIR = -1;
		}
		if (buttons == 6 ) {
			XDIR = 1;
			YDIR = -1;
		}
		if (buttons == 2 ) {
			XDIR = 1;
			YDIR = 0;
		}
		if (buttons == 10 ) {
			XDIR = 1;
			YDIR = 1;
		}
		if (buttons == 8 ) {
			XDIR = 0;
			YDIR = 1;
		}
		if (buttons == 9 ) {
			XDIR = -1;
			YDIR = 1;
		}

		/********** Adjust X and Y direction if the dot is about to cross the boundaries at the edges of the screen **********/
		if ( XCOR >= 79 ) {
			XDIR = -1;
		}

		if ( XCOR <= 0 ) {
			XDIR = 1;
		}

		if ( YCOR >= 59 ) {
			YDIR = -1;
		}

		if ( YCOR <= 0 ) {
			YDIR = 1;
		}





		/********** Adjust X and Y direction if the dot is about to bounce off the walls **********/
		/******************************************************************************************/
		/******************************************************************************************/


		// left-most wall
		if ( (XCOR == 9) && (YCOR >= 10) && (YCOR <= 49) && (XDIR == 1) ) {
			XDIR = -1;
		}
		if ( (XCOR == 11) && (YCOR >= 10) && (YCOR <= 49) && (XDIR == -1) ) {
			XDIR = 1;
		}
		if ( (XCOR == 10) && (YCOR == 9) && (YDIR == 1) ) {
			YDIR = -1;
		}
		if ( (XCOR == 10) && (YCOR == 50) && (YDIR == -1) ) {
			YDIR = 1;
		}
		if ( (XCOR == 9) && (YCOR == 9) && (XDIR == 1) && (YDIR == 1) ) {
			XDIR = -1;
			YDIR = -1;
		}
		if ( (XCOR == 11) && (YCOR == 9) && (XDIR == -1) && (YDIR == 1) ) {
			XDIR = 1;
			YDIR = -1;
		}
		if ( (XCOR == 9) && (YCOR == 50) && (XDIR == 1) && (YDIR == -1) ) {
			XDIR = -1;
			YDIR = 1;
		}
		if ( (XCOR == 11) && (YCOR == 50) && (XDIR == -1) && (YDIR == -1) ) {
			XDIR = 1;
			YDIR = 1;
		}

		// right-most wall
		if ( (XCOR == 67) && (YCOR >= 10) && (YCOR <= 49) && (XDIR == 1) ) {
			XDIR = -1;
		}
		if ( (XCOR == 69) && (YCOR >= 10) && (YCOR <= 49) && (XDIR == -1) ) {
			XDIR = 1;
		}
		if ( (XCOR == 68) && (YCOR == 9) && (YDIR == 1) ) {
			YDIR = -1;
		}
		if ( (XCOR == 68) && (YCOR == 50) && (YDIR == -1) ) {
			YDIR = 1;
		}
		if ( (XCOR == 67) && (YCOR == 9) && (XDIR == 1) && (YDIR == 1) ) {
			XDIR = -1;
			YDIR = -1;
		}
		if ( (XCOR == 69) && (YCOR == 9) && (XDIR == -1) && (YDIR == 1) ) {
			XDIR = 1;
			YDIR = -1;
		}
		if ( (XCOR == 67) && (YCOR == 50) && (XDIR == 1) && (YDIR == -1) ) {
			XDIR = -1;
			YDIR = 1;
		}
		if ( (XCOR == 69) && (YCOR == 50) && (XDIR == -1) && (YDIR == -1) ) {
			XDIR = 1;
			YDIR = 1;
		}

		// central cross
		if ( (XCOR == 38) && (YCOR >= 24) && (YCOR <= 35) && (XDIR == 1) ) {
		    XDIR = -1;
		}
		if ( (XCOR == 41) && (YCOR >= 24) && (YCOR <= 35) && (XDIR == -1) ) {
		    XDIR = 1;
		}
		if ( (XCOR >= 39) && (XCOR <= 40) && (YCOR == 23) && (YDIR == 1) ) {
		    YDIR = -1;
		}
		if ( (XCOR >= 39) && (XCOR <= 40) && (YCOR == 36) && (YDIR == -1) ) {
		    YDIR = 1;
		}
		if ( (XCOR == 33) && (YCOR >= 29) && (YCOR <= 30) && (XDIR == 1) ) {
		    XDIR = -1;
		}
		if ( (XCOR == 46) && (YCOR >= 29) && (YCOR <= 30) && (XDIR == -1) ) {
		    XDIR = 1;
		}
		if ( (XCOR >= 34) && (XCOR <= 45) && (YCOR == 28) && (YDIR == 1) ) {
		    YDIR = -1;
		}
		if ( (XCOR >= 34) && (XCOR <= 45) && (YCOR == 31) && (YDIR == -1) ) {
		    YDIR = 1;
		}



		if ( (XCOR == 33) && (YCOR == 28) && (XDIR == 1) && (YDIR == 1) ) {
		    XDIR = -1;
		    YDIR = -1;
		}
		if ( (XCOR == 33) && (YCOR == 31) && (XDIR == 1) && (YDIR == -1) ) {
		    XDIR = -1;
		    YDIR = 1;
		}
		if ( (XCOR == 38) && (YCOR == 23) && (XDIR == 1) && (YDIR == 1) ) {
		    XDIR = -1;
		    YDIR = -1;
		}
		if ( (XCOR == 38) && (YCOR == 36) && (XDIR == 1) && (YDIR == -1) ) {
		    XDIR = -1;
		    YDIR = 1;
		}
		if ( (XCOR == 41) && (YCOR == 23) && (XDIR == -1) && (YDIR == 1) ) {
		    XDIR = 1;
		    YDIR = -1;
		}
		if ( (XCOR == 41) && (YCOR == 36) && (XDIR == -1) && (YDIR == -1) ) {
		    XDIR = 1;
		    YDIR = 1;
		}
		if ( (XCOR == 46) && (YCOR == 28) && (XDIR == -1) && (YDIR == 1) ) {
		    XDIR = 1;
		    YDIR = -1;
		}
		if ( (XCOR == 46) && (YCOR == 31) && (XDIR == -1) && (YDIR == -1) ) {
		    XDIR = 1;
		    YDIR = 1;
		}

		// upper and lower walls
	        if ( (XCOR == 18) && (YCOR == 48) && (XDIR == 1) && (YDIR == 1) ) {
	            XDIR = -1;
	            YDIR = -1;
	        }
	        if ( (XCOR == 18) && (YCOR == 50) && (XDIR == 1) && (YDIR == -1) ) {
	            XDIR = -1;
	            YDIR = 1;
	        }
	        if ( (XCOR == 18) && (YCOR == 9) && (XDIR == 1) && (YDIR == 1) ) {
	            XDIR = -1;
	            YDIR = -1;
	        }
	        if ( (XCOR == 18) && (YCOR == 11) && (XDIR == 1) && (YDIR == -1) ) {
	            XDIR = -1;
	            YDIR = 1;
	        }
	        if ( (XCOR == 35) && (YCOR == 11) && (XDIR == -1) && (YDIR == -1) ) {
	            XDIR = 1;
	            YDIR = 1;
	        }
	        if ( (XCOR == 35) && (YCOR == 48) && (XDIR == -1) && (YDIR == 1) ) {
	            XDIR = 1;
	            YDIR = -1;
	        }
        
        
	        if ( (XCOR == 44) && (YCOR == 11) && (XDIR == 1) && (YDIR == -1) ) {
	            XDIR = -1;
	            YDIR = 1;
	        }
	        if ( (XCOR == 44) && (YCOR == 48) && (XDIR == 1) && (YDIR == 1) ) {
	            XDIR = -1;
	            YDIR = -1;
	        }
	        if ( (XCOR == 60) && (YCOR == 9) && (XDIR == -1) && (YDIR == 1) ) {
	            XDIR = 1;
	            YDIR = -1;
	        }
	        if ( (XCOR == 60) && (YCOR == 11) && (XDIR == -1) && (YDIR == -1) ) {
	            XDIR = 1;
	            YDIR = 1;
	        }
	        if ( (XCOR == 60) && (YCOR == 48) && (XDIR == -1) && (YDIR == 1) ) {
	            XDIR = 1;
	            YDIR = -1;
	        }
	        if ( (XCOR == 60) && (YCOR == 50) && (XDIR == -1) && (YDIR == -1) ) {
	            XDIR = 1;
	            YDIR = 1;
	        }


                if ( (XCOR == 18) && (YCOR == 10) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 18) && (YCOR == 49) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 60) && (YCOR == 10) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR == 60) && (YCOR == 49) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR == 33) && (YCOR >= 0) && (YCOR <= 9) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 35) && (YCOR >= 0) && (YCOR <= 10) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR == 44) && (YCOR >= 0) && (YCOR <= 10) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 46) && (YCOR >= 0) && (YCOR <= 10) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR == 33) && (YCOR >= 49) && (YCOR <= 59) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 35) && (YCOR >= 49) && (YCOR <= 59) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR == 44) && (YCOR >= 49) && (YCOR <= 59) && (XDIR == 1) ) {
                    XDIR = -1;
                }
                if ( (XCOR == 46) && (YCOR >= 49) && (YCOR <= 59) && (XDIR == -1) ) {
                    XDIR = 1;
                }
                if ( (XCOR >= 19) && (XCOR <= 34) && (YCOR == 9) && (YDIR == 1) ) {
                    YDIR = -1;
                }
                if ( (XCOR >= 19) && (XCOR <= 34) && (YCOR == 11) && (YDIR == -1) ) {
                    YDIR = 1;
                }
                if ( (XCOR >= 19) && (XCOR <= 34) && (YCOR == 48) && (YDIR == 1) ) {
                    YDIR = -1;
                }
                if ( (XCOR >= 19) && (XCOR <= 34) && (YCOR == 50) && (YDIR == -1) ) {
                    YDIR = 1;
                }
                if ( (XCOR >= 45) && (XCOR <= 59) && (YCOR == 9) && (YDIR == 1) ) {
                    YDIR = -1;
                }
                if ( (XCOR >= 45) && (XCOR <= 59) && (YCOR == 11) && (YDIR == -1) ) {
                    YDIR = 1;
                }
                if ( (XCOR >= 45) && (XCOR <= 59) && (YCOR == 48) && (YDIR == 1) ) {
                    YDIR = -1;
                }
                if ( (XCOR >= 45) && (XCOR <= 59) && (YCOR == 50) && (YDIR == -1) ) {
                    YDIR = 1;
                }

		/******************************************************************************************/
		/******************************************************************************************/
		/******************************************************************************************/





		/********** Capture old X and Y positions; determine new X and Y positions **********/
		old_XCOR = XCOR;
		old_YCOR = YCOR;
		XCOR += XDIR;
		YCOR += YDIR;

		/********** Read Switches value, send to LEDs; read Button values, send to Seven Segment Display **********/
		*LEDS = *SWITCHES;
		*SSD = *BUTTONS;	
	}
}

/********** Draws a horizontal line starting at coordinates (X,Y), ending at coordinates (toX,Y); color is specified by the argument 'color' **********/
static void draw_horizontal_line(int X, int Y, int toX, int color) {
	toX++;
	for (; X != toX; X++) {
		draw_dot(X, Y, color);
	}
}

/********** Draws a vertical line starting at coordinates (X,Y), ending at coordinates (X,toY); color is specified by the argument 'color' **********/
static void draw_vertical_line(int X, int Y, int toY, int color) {
	toY++;
	for (; Y != toY; Y++) {
		draw_dot(X, Y, color);
	}
}

/********** Fills the screen with BG_COLOR ***********/
static void draw_background() {
	for (int Y = 0; Y != 60; Y++) {
		draw_horizontal_line(0, Y, 79, BG_COLOR);
	}
}

/********** Draws a small square (a single memory cell) **********/
static void draw_dot(int X, int Y, int color) {
	*VG_ADDR = (Y << 7) | X;	/* store into the address IO register */
	*VG_COLOR = color;		/* store into the color IO register, which triggers the actual write to the framebuffer, at the address previously stored in the address IO register */
}
