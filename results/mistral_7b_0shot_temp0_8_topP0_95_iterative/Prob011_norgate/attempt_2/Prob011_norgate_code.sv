
always @(posedge clk) begin
  out <= !((a | b)); // Using De-Morgan's law to implement NOR gate
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
