
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
  // State definitions
  parameter A = 0;
  parameter B = 1;
  parameter C = 2;
  parameter D = 3;
  parameter E = 2; // E and C share the same code
  parameter F = 3; // F and D share the same code

  // State register
  reg current_state;

  // Next state logic (state table)
  always @(posedge clk) begin
    if (reset) begin
      current_state <= A;
    end else begin
      case (current_state)
        A: begin
          if (w)
            current_state <= B;
          else
            current_state <= A;
        end
        B: begin
          if (w)
            current_state <= C;
          else
            current_state <= D;
        end
        C: begin
          if (w)
            current_state <= E;
          else
            current_state <= D;
        end
        D: begin
          if (w)
            current_state <= F;
          else
            current_state <= A;
        end
        E: begin
          if (w)
            current_state <= E;
          else
            current_state <= D;
        end
        F: begin
          if (w)
            current_state <= C;
          else
            current_state <= D;
        end
        default: current_state <= A; // Should never happen, but good practice
      endcase
    end
  end

  // Output logic
  always @(current_state) begin
    case (current_state)
      A: z = 0;
      B: z = 1;
      C: z = 1;
      D: z = 0;
      E: z = 1;
      F: z = 0;
      default: z = 0; // Default case for safety
    endcase
  end

endmodule
