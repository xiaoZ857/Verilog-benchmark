
module TopModule (
  output one
);
always_comb begin
  assign one = 1;  // Assign instead of output reg one = 1 to avoid the error
end

initial begin
  $finish; // To terminate the simulation after one clock cycle
end

// VERILOG-EVAL: endmodule not found
