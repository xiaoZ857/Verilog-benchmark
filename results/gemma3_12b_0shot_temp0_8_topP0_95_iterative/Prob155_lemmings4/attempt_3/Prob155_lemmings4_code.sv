
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
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;
  parameter FALLING = 2'b10;
  parameter DIGGING = 2'b11;

  reg [1:0] current_state;
  reg [4:0] fall_count;

  // Outputs based on current state
  always @(current_state) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
      WALK_LEFT: begin
        walk_left = 1;
      end
      WALK_RIGHT: begin
        walk_right = 1;
      end
      FALLING: begin
        aaah = 1;
      end
      DIGGING: begin
        digging = 1;
      end
      default: begin
        // Should never happen, but good to have a default
      end
    endcase
  end

  // State transition logic (Moore FSM)
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
      fall_count <= 0;
    end else begin
      case (current_state)
        WALK_LEFT: begin
          if (bump_left) begin
            current_state <= WALK_RIGHT;
          end else if (bump_right) begin
            current_state <= WALK_LEFT;
          end else if (!ground) begin
            current_state <= FALLING;
            fall_count <= 0;
          end else if (dig && ground) begin
            current_state <= DIGGING;
          end else begin
            current_state <= WALK_LEFT;
          end
        end
        WALK_RIGHT: begin
          if (bump_left) begin
            current_state <= WALK_LEFT;
          end else if (bump_right) begin
            current_state <= WALK_RIGHT;
          end else if (!ground) begin
            current_state <= FALLING;
            fall_count <= 0;
          end else if (dig && ground) begin
            current_state <= DIGGING;
          end else begin
            current_state <= WALK_RIGHT;
          end
        end
        FALLING: begin
          if (ground) begin
            if (fall_count >= 20) begin
              // Splatter!  Go to a state where all outputs are 0.
              // To represent this in the FSM, we can just stick with FALLING.
              // The outputs are defined by the always @(current_state) block
              // that sets them to 0.
            end else begin
              current_state <= WALK_LEFT; // or WALK_RIGHT, depending on original direction
            end
          end else begin
            current_state <= FALLING;
            fall_count <= fall_count + 1;
          end
        end
        DIGGING: begin
          if (!ground) begin
            current_state <= FALLING;
            fall_count <= 0;
          end else if (dig) begin
            current_state <= DIGGING;
          end else begin
            current_state <= WALK_LEFT; // or WALK_RIGHT, depending on original direction
          end
        end
        default: begin
          current_state <= WALK_LEFT;
          fall_count <= 0;
        end
      endcase
    end
  end
endmodule
