
module TopModule (
  output one
);
always_comb begin
  reg one; // Use output reg instead of assign to declare the output signal
  one = 1'b1; // Assign value to the output signal
end

initial begin
  #1 $finish; // Simulation terminates after one clock cycle
end

// Endmodule declaration
endmodule
