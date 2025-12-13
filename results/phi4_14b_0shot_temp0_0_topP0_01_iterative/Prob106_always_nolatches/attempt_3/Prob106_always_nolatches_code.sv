
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
always @(posedge clk) begin
    // Initialize outputs to 0 (no key pressed)
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    case(scancode)
        16'hE06B: begin
            left = 1'b1;   // Left arrow
        end
        16'hE072: begin
            down = 1'b1;   // Down arrow
        end
        16'hE074: begin
            right = 1'b1;  // Right arrow
        end
        16'hE075: begin
            up = 1'b1;     // Up arrow
        end
    endcase
end

endmodule
