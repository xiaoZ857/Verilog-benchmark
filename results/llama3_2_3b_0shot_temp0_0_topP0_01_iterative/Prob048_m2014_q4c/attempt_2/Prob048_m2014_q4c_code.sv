
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
// D Flip-Flop Logic
always @(posedge clk) begin
  if (!r) begin  // If reset is active high, set to 0
    q <= 0;
  else begin  // Otherwise, update next state based on current data and previous state
    q <= d;
  end
end

// Assign the output of the flip-flop
assign q = q;

// VERILOG-EVAL: endmodule not found
