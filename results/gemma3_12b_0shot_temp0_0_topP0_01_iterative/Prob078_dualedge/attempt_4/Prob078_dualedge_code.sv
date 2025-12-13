
module TopModule (
  input clk,
  input d,
  output reg q
);
  reg q_n; // Internal signal for the previous value of q

  always @(posedge clk) begin
    q_n <= q;
  end

  always @(negedge clk) begin
    q <= d; // Update q on the negative edge
  end

// VERILOG-EVAL: endmodule not found
