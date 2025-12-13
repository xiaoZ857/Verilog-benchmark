
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
  // The flip-flop will store the current value of the stage.
  // It's clocked by clk and enabled by E.
  always @(posedge clk) begin
    if (L) begin
      Q <= R; // Load the value R when L is high
    end else if (E) begin
      Q <= w; // Shift in the input w when E is high
    end else begin
      // Hold the current value
      Q <= Q; // Hold the current value
    end
  end

endmodule
