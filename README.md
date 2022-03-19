# Project Summary

Zig-zag is a game I developed to run on the OTTER MCU for Cal Poly's CPE 233 class. Similar to Pac-Man, the objective is to travel across the game board and "eat" the red dots littered across the screen in random locations. The cursor is constantly moving, and the player controls the speed and direction it moves in. The green lines are walls that the cursor bounces off of. The edges of the screen are also walls which the cursor will bounce off of.

# Controls

The game is played using the switches and buttons on the BASYS3 board. The UP button causes the cursor to travel up, the DOWN button causes the cursor to travel down, the RIGHT button causes the cursor to travel right, and the LEFT button causes the cursor to travel left. Additionally, pressing 2 buttons at the same time will cause the cursor to travel diagonally ( ex, LEFT and UP simultaneously will move the cursor along the north-west diagonal).

# Adjusting Speed

The switches on the BASYS3 board can be used to control the cursor's speed. The switches are constantly read by the OTTER as a binary value. A value of 0 (all switches down) is the fastest possible speed. A value of 65535 (all switches up) is the slowest possible speed. A recommended speed is with the 3 left-most switches up.

# Resetting Game

The game can be reset by pressing the LEFT, CENTER, and RIGHT buttons at the same time.

# Hardware Development

The hardware modules for this project included the standard OTTER MCU with interrupts, and the VGA 80x60 Driver.

# Software Development

The software for this game was developed entirely in C. 4 functions were borrowed from Dr. Callenes's "vga_demo_c" program: draw_dot(), draw_background(), draw_horizontal_line(), and draw_vertical_line. All other code is original work.

# Video Demonstration

https://www.youtube.com/watch?v=viKIo6I3PBU

# Challenges Encountered

There were several strange issues that came up while writing C code for this game. I was unable to use basic features of C, such as arrays, to quickly and efficiently implement the game features that I wanted. The code would compile just fine, and through the use of the GDB Debugger tool, I could verify that the logic of my code was doing what I wanted it to (i.e., variables had values I expected them to have, etc.). However after generating the bitstream and connecting the OTTER to my moniter, the game would be doing something completely different. Without the use of a specialized OTTER programmger/debugger tool, pinpointing the source of these problems was extremely difficult. Every change to the code, no matter how small, meant waiting 10 minutes to generate a new bitstream.

For this reason, I had to manually write hundreds of lines of code that could have been implemented very easily using an array and loops. For instance, I had to manually place every single red dot, and every single green line. Then, I had to use about 70 "if" statements to properly implement the "bounce" feature to prevent the cursor from from off the screen or through the green walls (every if statement checks the cursor's position and direction of movement, and toggles the direction if necessary).

# Ideas For Additional Features

If future 233 students are interested in improving this game, there are a number of features I had considered adding if there had been more time:
1. More complex layout of walls, or make the layout change periodically while playing.
2. Timer, or some way of "keeping score".
3. Obstacles that must be avoided.
