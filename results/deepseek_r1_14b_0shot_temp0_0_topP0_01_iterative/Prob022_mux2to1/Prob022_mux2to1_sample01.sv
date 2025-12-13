
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
always_comb begin
  if (sel == 0) begin
    out <= a;
  end else begin
    out <= b;
  end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
