
`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  output out
);

always_comb begin
  out = (~a & ~b) | (a & b);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
