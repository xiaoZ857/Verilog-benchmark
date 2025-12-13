
module TopModule (
  input clk,
  input d,
  output reg q_r,
  output reg q_f
);

// Level sensitive D flip-flop for positive edge
always @(posedge clk) begin
  if (d)
    q_r <= ~q_r;
end

// Level sensitive D flip-flop for negative edge
always @(negedge clk) begin
  if (d)
    q_f <= ~q_f;
end

assign q = q_r ^ q_f; // XOR of both outputs to get the dual-edge triggered behavior

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
