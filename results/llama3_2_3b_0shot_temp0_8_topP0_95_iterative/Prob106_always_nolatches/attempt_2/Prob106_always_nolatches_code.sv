
module TopModule(
    input [15:0] scancode, 
    output reg left, 
    output reg down, 
    output reg right, 
    output reg up
);

// Define the arrow key scancodes as constants for readability and maintainability
constant LEFT_ARROW = 16#hex06b;
constant DOWN_ARROW = 16#hex072;
constant RIGHT_ARROW = 16#hex074;
constant UP_ARROW = 16#hex075;

// Create a case statement to handle each possible scancode
case (scancode)
    LEFT_ARROW: left = 1; down = 0; right = 0; up = 0;
    DOWN_ARROW: down = 1; left = 0; right = 0; up = 0;
    RIGHT_ARROW: right = 1; down = 0; left = 0; up = 0;
    UP_ARROW: up = 1; left = 0; down = 0; right = 0;
endcase

// Initialize all output signals as 0 at the beginning of each clock cycle
always @(posedge clk) begin
    left <= 0;
    down <= 0;
    right <= 0;
    up <= 0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
