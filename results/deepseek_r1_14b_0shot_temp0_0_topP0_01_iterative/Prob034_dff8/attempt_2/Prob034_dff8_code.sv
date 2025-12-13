
// Timescale directive should be placed outside the module
`timescale 1ns/1ps

module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

generate
  for (i = 0; i < 8; i++) begin : dff_gen
    D flip_flop dff_i (
      .clk(clk),
      .d(d[i]),
      .q(q[i])
    );
  end
endgenerate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
