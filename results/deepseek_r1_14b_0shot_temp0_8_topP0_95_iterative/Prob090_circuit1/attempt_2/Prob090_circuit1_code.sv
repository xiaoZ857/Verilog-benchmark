
module TopModule (
  input a,
  input b,
  output q
);
always @(*) begin
  q = a ^ b;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
