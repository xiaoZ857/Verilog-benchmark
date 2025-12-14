
always @(posedge clk) begin
  out <= (~a & b & ~c) | (a & ~b & c) | (~a & b & c) | (a & b & ~c);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
