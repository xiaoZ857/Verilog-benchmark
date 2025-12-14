
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);

  // Always block triggered on positive clock edge
  always @ (posedge clk) begin
    // Default all outputs to 0
    left <= 1'b0;
    down <= 1'b0;
    right <= 1'b0;
    up <= 1'b0;

    case (scancode)
      16'hE06B: begin
        left <= 1'b1; // Left arrow key pressed
      end
      16'hE072: begin
        down <= 1'b1; // Down arrow key pressed
      end
      16'hE074: begin
        right <= 1'b1; // Right arrow key pressed
      end
      16'hE075: begin
        up <= 1'b1;    // Up arrow key pressed
      end
      default: begin
        // All outputs remain 0 for any other scancode
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
