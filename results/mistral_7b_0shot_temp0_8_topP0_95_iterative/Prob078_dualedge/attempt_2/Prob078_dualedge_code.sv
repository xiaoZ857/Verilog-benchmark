
module TopModule (
  input clk,
  input d,
  output reg q
);
always @(posedge clk or negedge clk) begin
  if (posedge clk)
    q <= d; // Storing data on positive edge of clock
  else if (negedge clk)
    q <= !q; // Preserve current value on negative edge of clock
end

// To store the previous value from the positive edge on the negative edge,
// we invert the current value after the positive edge before checking for the negative edge.
always @(posedge clk negedge clk) begin
  if (posedge clk)
    q_negedge <= !q; // Store the previous value on the positive edge
end

assign q = q_negedge; // Invert the stored value to get actual output

// For clarity, you can separate the outputs into two flip-flops if needed:
// module TopModule (
//   input clk,
//   input d,
//   output reg posedge_q,
//   output reg negedge_q
// );

// always @(posedge clk) begin
//   posedge_q <= d;
// end

// always @(negedge clk) begin
//   negedge_q <= posedge_q;
// end

// assign q = posedge_q ^ negedge_q;

endmodule
