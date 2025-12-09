
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  // Define states
  localparam WALK_LEFT = 0;
  localparam WALK_RIGHT = 1;

  reg current_state;
  
  // Determine if direction needs to change
  wire direction_change;
  assign direction_change = bump_left | bump_right;

  // Next state logic and outputs
  always @* begin
    walk_left = (current_state == WALK_LEFT);
    walk_right = (current_state == WALK_RIGHT);
    
    if (direction_change) begin
      current_state = !current_state;
    end
  end

  // State register with asynchronous reset
  always @(posedge clk or areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      // No change on no direction_change, otherwise use next state from above
      if (direction_change) begin
        current_state <= !current_state;
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
