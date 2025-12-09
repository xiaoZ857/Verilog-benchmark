
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);

always_comb {
    // Check if the scancode matches any of the arrow keys
    left = (scancode == 16'h06b);
    down = (scancode == 16'h072);
    right = (scancode == 16'h074);
    up = (scancode == 16'h075);

    // If none of the above conditions are met, all outputs should be 0
    left = left | (!left & (!down & !right & !up));
    down = down | (!left & (!down & !right & !up));
    right = right | (!left & (!down & !right & !up));
    up = up | (!left & (!down & !right & !up));

    // Ensure all outputs are asserted
    left = left | down;
    down = down | right;
    right = right | up;
    up = up | left;
}

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
