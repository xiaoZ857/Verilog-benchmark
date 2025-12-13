
module TopModule (
  input clk,
  input x,
  output z
);

  // Define internal signals
  wire w_xor, w_and, w_or;
  reg ff1, ff2, ff3;

  // D flip-flops with initial reset to 0
  initial begin
    ff1 = 0;
    ff2 = 0;
    ff3 = 0;
  end

  always @(posedge clk) begin
    ff1 <= x ^ ff1;
    ff2 <= x & (~ff2);
    ff3 <= x | (~ff3);
  end

  // Compute the three gate outputs
  assign w_xor = x ^ ff1;
  assign w_and = x & (~ff2);
  assign w_or = x | (~ff3);

  // Three-input NOR gate for output Z
  nor3 (z, w_xor, w_and, w_or);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
