
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
always @(posedge clk or negedge areset) begin
  if (areset) begin
    state_A <= 1'b1;
    state_B <= 1'b0;
    state_C <= 1'b0;
    state_D <= 1'b0;
    out <= 1'b0;
  end else begin
    case (state_A)
      1'b1: begin
        if (in == 1'b0) begin
          state_A <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b0;
        end else begin
          state_A <= 1'b0;
          state_B <= 1'b1;
        end
      end,
      1'b0: begin
        if (in == 1'b0) begin
          state_C <= 1'b0;
          state_B <= 1'b1;
          out <= 1'b0;
        end else begin
          state_C <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b0;
        end
      end,
      1'b0: begin
        if (in == 1'b0) begin
          state_A <= 1'b0;
          state_D <= 1'b0;
          out <= 1'b0;
        end else begin
          state_A <= 1'b1;
          state_C <= 1'b1;
          out <= 1'b1;
        end
      end,
      1'b0: begin
        if (in == 1'b1) begin
          state_C <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b1;
        end else begin
          state_C <= 1'b0;
          state_B <= 1'b1;
          out <= 1'b0;
        end
      end
    endcase
    state_D <= state_A; // Assign state D based on state A for the last state transition
  end
end

// Add missing output signals
output reg state_A, state_B, state_C, state_D;

endmodule
