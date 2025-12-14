
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
  parameter A = 1'b0;
  parameter B = 1'b1;

  reg current_state;
  reg next_state;

  always @(posedge clk) begin
    if (reset) begin
      current_state <= B;
    else begin
      current_state <= next_state;
    end
  end

  always @(*) begin
    next_state = current_state; // Default: stay in current state

    case (current_state)
      A: begin
        if (in == 0) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (in == 0) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      end
      default: begin
        next_state = B; // Default to B in case of unexpected state
      end
    endcase
  end

  assign out = current_state == B ? 1'b1 : 1'b0;

endmodule
