
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
always @(*) begin
    // Default values for all outputs
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    // Case statement to determine which arrow key is pressed based on scancode
    case (scancode)
        16'hE06B: left = 1'b1;     // Left arrow
        16'hE072: down = 1'b1;     // Down arrow
        16'hE074: right = 1'b1;    // Right arrow
        16'hE075: up = 1'b1;       // Up arrow
        default: ;                 // Do nothing for other scancodes
    endcase
end
endmodule
