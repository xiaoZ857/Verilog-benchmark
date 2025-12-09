
always @(posedge clk) begin
  out <= (!a && !b) || (a && b && !c) || (a && c && !d) || (!a && !c && d);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
