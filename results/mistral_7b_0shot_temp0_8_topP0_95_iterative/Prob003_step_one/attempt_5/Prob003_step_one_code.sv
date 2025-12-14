
module TopModule (
  output one
);
always @(posedge clk) begin
  one <= 1'b1; // Assign logic high to the output on each rising clock edge
end

initial begin
  #1 $finish; // Simulation terminates after one clock cycle
end

// VERILOG-EVAL: endmodule not found
