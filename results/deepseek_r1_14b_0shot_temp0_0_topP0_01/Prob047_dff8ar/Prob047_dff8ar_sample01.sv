

module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

generate
  for (i = 0; i < 8; i++) begin : dff_i
    DFF 
      #(.clk(clk), .areset(areset)) 
      dff (
        .d(d[i]),
        .q(q[i])
      );
  end
endgenerate

// VERILOG-EVAL: endmodule not found
