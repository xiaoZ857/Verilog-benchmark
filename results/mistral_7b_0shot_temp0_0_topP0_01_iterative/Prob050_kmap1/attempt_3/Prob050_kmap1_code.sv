
module TopModule (
  input a,
  input b,
  input c,
  output out
);
always @(posedge clk) begin
  out <= a ^ b ^ c; // XOR gate for all combinations
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
