
module TopModule (
  output reg out
);

always_comb begin
  out = 0;
end

initial begin
  $finish; // To end simulation immediately after compilation.
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
