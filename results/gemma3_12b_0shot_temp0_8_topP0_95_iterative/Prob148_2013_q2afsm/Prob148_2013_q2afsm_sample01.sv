
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  // State definitions
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // State variables
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Output variables
  reg [3:1] g;

  // State table
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always @(*) begin
    next_state = current_state; // Default: stay in current state

    case (current_state)
      A: begin
        if (r[1]) begin
          next_state = B;
        end else if (r[2]) begin
          next_state = C;
        end else if (r[3]) begin
          next_state = B; // Prioritize device 1 if device 1 and 3 request
        end
      end

      B: begin
        if (r[1]) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end

      C: begin
        if (r[2]) begin
          next_state = C;
        end else begin
          next_state = A;
        end
      end

      default: begin
        next_state = A;
      end
    endcase
  end

  // Output logic (using continuous assignment)
  assign g[1] = (current_state == B) ? 1 : 0;
  assign g[2] = (current_state == C) ? 1 : 0;
  assign g[3] = 0; // No grant for device 3.
  assign g[4] = 0; // No grant for device 4.
endmodule
