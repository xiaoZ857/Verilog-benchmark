
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);

always @(posedge clk) begin
  if (r) begin
    q <= 1'b0;
  end else begin
    q <=

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
