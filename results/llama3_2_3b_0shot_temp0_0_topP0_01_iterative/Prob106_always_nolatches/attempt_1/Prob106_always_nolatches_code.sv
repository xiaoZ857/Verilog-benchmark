
module TopModule(
    input [15:0] scancode,
    output reg left, 
    output reg down, 
    output reg right, 
    output reg up
);

// Define the arrow key scancodes as constants for readability
const int LEFT_ARROW = 16'h06b;
const int DOWN_ARROW = 16'h072;
const int RIGHT_ARROW = 16'h074;
const int UP_ARROW = 16'h075;

// Initialize outputs to zero (i.e., no arrow key pressed)
assign left = 0;
assign down = 0;
assign right = 0;
assign up = 0;

// Use a case statement to map the scancode to the correct output
case(scancode)
    LEFT_ARROW: left = 1;
    DOWN_ARROW: down = 1;
    RIGHT_ARROW: right = 1;
    UP_ARROW: up = 1;
    default: // Anything else, no arrow key pressed
endcase

endmodule

// VERILOG-EVAL: errant inclusion of module definition
