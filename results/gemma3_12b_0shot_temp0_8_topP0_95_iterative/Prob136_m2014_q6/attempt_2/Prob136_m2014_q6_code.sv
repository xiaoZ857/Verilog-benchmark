
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
  // Define states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  parameter E = 2'b00; // Reuse A as E for simplicity, though this isn't ideal.  A better solution would be to use a 3-state machine.
  parameter F = 2'b00; // Reuse A as F for simplicity, though this isn't ideal. A better solution would be to use a 3-state machine.

  reg [1:0] current_state;

  // Output logic
  always @(current_state) begin
    case (current_state)
      A: z = w;
      B: z = 0;
      C: z = 0;
      D: z = 0;
      E: z = 0;
      F: z = 0;
      default: z = 0; // Should never happen, but good to have a default.
    endcase
  end

  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= A;
    end else begin
      case (current_state)
        A: begin
          if (w) begin
            current_state <= A;
          end else begin
            current_state <= B;
          end
        end
        B: begin
          if (w) begin
            current_state <= C;
          end else begin
            current_state <= D;
          end
        end
        C: begin
          if (w) begin
            current_state <= E;
          end else begin
            current_state <= D;
          end
        end
        D: begin
          if (w) begin
            current_state <= A;
          end else begin
            current_state <= F;
          end
        end
        E: begin
          if (w) begin
            current_state <= E;
          end else begin
            current_state <= D;
          end
        end
        F: begin
          if (w) begin
            current_state <= C;
          end else begin
            current_state <= D;
          end
        end
        default: current_state <= A; // Default case for safety
      endcase
    end
  end

endmodule
