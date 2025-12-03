
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

generate
  genvar i;
  for (i = 0; i < 8; i++) begin : dff_gen
    DFlipFlop dflipflop (
      .clk(clk),
      .d(d[i]),
      .reset(reset),
      .q(q[i])
    );
  end
endgenerate

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
