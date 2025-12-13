
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);

  // Define states
  parameter WALK_LEFT = 2'b00
  parameter WALK_RIGHT = 2'b01
  parameter FALLING = 2'b10
  parameter DIGGING = 2'b11

  reg [1:0] current_state;
  reg [1:0] next_state;

  // Outputs
  reg walk_left_reg;
  reg walk_right_reg;
  reg aaah_reg;
  reg digging_reg;

  // Assign outputs
  assign walk_left = walk_left_reg;
  assign walk_right = walk_right_reg;
  assign aaah = aaah_reg;
  assign digging = digging_reg;

  // State register
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always @(*) begin
    next_state = current_state; // Default: stay in the current state

    case (current_state)
      WALK_LEFT: begin
        if (bump_left) begin
          next_state = WALK_RIGHT;
        end else if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (!ground) begin
          next_state = FALLING;
        end else if (dig && ground) begin
          next_state = DIGGING;
        end
      end

      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (bump_right) begin
          next_state = WALK_LEFT;
        end else if (!ground) begin
          next_state = FALLING;
        end else if (dig && ground) begin
          next_state = DIGGING;
        end
      end

      FALLING: begin
        // No change in state while falling
      end

      DIGGING: begin
        if (!ground) begin
          next_state = FALLING;
        end
      end
    endcase
  end

  // Output logic
  always @(current_state) begin
    case (current_state)
      WALK_LEFT: begin
        walk_left_reg = 1;
        walk_right_reg = 0;
        aaah_reg = 0;
        digging_reg = 0;
      end
      WALK_RIGHT: begin
        walk_left_reg = 0;
        walk_right_reg = 1;
        aaah_reg = 0;
        digging_reg = 0;
      end
      FALLING: begin
        walk_left_reg = 0;
        walk_right_reg = 0;
        aaah_reg = 1;
        digging_reg = 0;
      end
      DIGGING: begin
        walk_left_reg = 0;
        walk_right_reg = 0;
        aaah_reg = 0;
        digging_reg = 1;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
