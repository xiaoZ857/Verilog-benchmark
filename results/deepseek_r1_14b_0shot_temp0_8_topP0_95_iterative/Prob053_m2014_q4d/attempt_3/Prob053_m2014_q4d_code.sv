
module TopModule (
  input clk,
  input in,
  output logic out
);
// Implement D flip-flop with XOR feedback
always @(posedge clk) 
    out <= in ^ out;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
