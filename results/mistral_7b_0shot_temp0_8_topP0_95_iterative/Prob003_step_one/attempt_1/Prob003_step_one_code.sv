
module TopModule (
  output reg one
);

always_comb begin
  one = 1;
end

initial begin
  $finish; // To terminate the simulation after one clock cycle
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
