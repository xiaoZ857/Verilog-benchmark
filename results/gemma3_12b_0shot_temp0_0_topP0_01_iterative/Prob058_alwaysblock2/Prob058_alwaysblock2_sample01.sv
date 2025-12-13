
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  // XOR gate using assign statement
  assign out_assign = a ^ b;

  // XOR gate using combinational always block
  always_comb begin
    out_always_comb = a ^ b;
  end

  // XOR gate using clocked always block
  always @(posedge clk) begin
    out_always_ff = a ^ b;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
