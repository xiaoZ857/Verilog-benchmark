
module TopModule (
  input a,
  input b,
  input c,
  output out
);
always @(posedge clk) begin
  out <= ((~a & b) | (a & ~b)) + ((~a & c) | (a & c));
end

// VERILOG-EVAL: endmodule not found
