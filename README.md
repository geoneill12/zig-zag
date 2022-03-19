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

<iframe width="560" height="315" src="https://www.youtube.com/embed/viKIo6I3PBU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

