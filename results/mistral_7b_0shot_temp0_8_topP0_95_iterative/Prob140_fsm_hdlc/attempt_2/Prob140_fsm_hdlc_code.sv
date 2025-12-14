
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    current_state <= 0; // Reset state to 0
  end else begin
    case(current_state)
      0: begin
        if (in == 1'b1) begin
          current_state <= 1; // First bit of a sequence
        end
      end,
      1: begin
        if (in == 1'b0) begin
          current_state <= 2; // First 0 after sequence start
        end else if(in == 1'b1) begin
          current_state <= [5:0]current_state + 1; // Continue counting
        end
      end,
      6: begin
        if (in == 1'b0) begin
          current_state <= 7; // First 0 after 7 consecutive 1s
        end
      end,
      7: begin
        err <= 1'b1; // Error state
        current_state <= 8; // Reset error state
      end,
      _: current_state <= current_state; // Ignore invalid states
    endcase

    // Discard bit when in sequence 5
    assign disc = (current_state == 5);

    // Flag beginning or end of frame
    always @(posedge clk) begin
      if (((current_state == 6) || (current_state == 11)) && !disc) begin
        flag <= 1'b1;
      end
    end
  end
end

// Signal an error if there are 7 or more consecutive 1s and not discarding a bit
always @(posedge clk) begin
  if ((current_state >= 7) && !disc) begin
    err <= 1'b1;
  end
end

// Resetting error state when the FSM is reset
assign err = (!reset) ? 1'b0 : err;

endmodule
