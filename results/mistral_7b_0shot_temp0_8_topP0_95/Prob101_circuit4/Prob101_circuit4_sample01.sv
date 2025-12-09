
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg q
);

always @(posedge clk) begin
  q <= a ^ b ^ c ^ d; // XOR operation
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
