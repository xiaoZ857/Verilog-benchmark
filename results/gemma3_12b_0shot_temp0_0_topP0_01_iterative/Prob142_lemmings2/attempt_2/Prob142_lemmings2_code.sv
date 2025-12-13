
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);
  // Define states
  parameter LEFT = 2'b00
  parameter RIGHT = 2'b01

  // State register
  reg [1:0] current_state;

  // Output registers
  reg walk_left_reg;
  reg walk_right_reg;
  reg aaah_reg;

  // State transitions
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= LEFT;
    end else begin
      case (current_state)
        LEFT: begin
          if (bump_left) begin
            current_state <= RIGHT;
          end else if (bump_right) begin
            current_state <= RIGHT;
          end else if (!ground) begin
            current_state <= LEFT; // Remain in LEFT state while falling
          end else begin
            current_state <= LEFT;
          end
        end
        RIGHT: begin
          if (bump_left) begin
            current_state <= LEFT;
          end else if (bump_right) begin
            current_state <= LEFT;
          end else if (!ground) begin
            current_state <= RIGHT; // Remain in RIGHT state while falling
          end else begin
            current_state <= RIGHT;
          end
        end
        default: begin
          current_state <= LEFT;
        end
      endcase
    end
  end

  // Output logic (Moore machine)
  always @(current_state) begin
    walk_left_reg = 0;
    walk_right_reg = 0;
    aaah_reg = 0;

    case (current_state)
      LEFT: begin
        walk_left_reg = 1;
      end
      RIGHT: begin
        walk_right_reg = 1;
      end
      default: begin
        walk_left_reg = 0;
        walk_right_reg = 0;
      end
    endcase

    if (!ground) begin
      aaah_reg = 1;
    end
  end

  // Assign outputs
  assign walk_left = walk_left_reg;
  assign walk_right = walk_right_reg;
  assign aaah = aaah_reg;

endmodule
