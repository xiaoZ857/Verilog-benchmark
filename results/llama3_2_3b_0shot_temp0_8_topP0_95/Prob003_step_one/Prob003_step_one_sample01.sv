
// Define the top module
module TopModule(
  // Output signal one
  output one
);

// Always block to ensure output is always driven high
always @(*)
begin
  one = 1;
end

// Or, you can also use a combinatorial logic block for this simple case
// but using an always block is more suitable for this type of task.

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
