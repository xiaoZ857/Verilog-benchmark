
module TopModule (
  output reg one; // Declare output as reg for combinational signals and registers for sequential signals
);

always @(posedge clk) begin
  one <= 1'b1; // Assign value to the output on each rising clock edge
end

initial begin
  #1 $finish; // Simulation terminates after one clock cycle
end

// Endmodule declaration
endmodule

// VERILOG-EVAL: errant inclusion of module definition
