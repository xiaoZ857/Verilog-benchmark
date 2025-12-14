
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
always @(posedge clk) begin
  if (E) D <= R; // Load data into D when enable (E) is high
  else D <= Q; // Else, keep the previous value of Q
end

assign w = R when (E && !L), w otherwise; // Multiplexer for the first stage
always @(posedge clk) begin
  if (L) Q <= D; // Load new value to Q when load (L) is high
  else Q <= {Q[0], D}; // Else, shift Q left by one bit and set the first bit as D
end

endmodule
