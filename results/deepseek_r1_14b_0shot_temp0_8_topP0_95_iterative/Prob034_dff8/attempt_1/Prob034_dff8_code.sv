
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

  // Implement 8 D flip-flops using a generate statement
  generate
    for (i = 0; i < 8; i++) begin : d_ff_gen
      always @(posedge clk) 
        q[i] <= d[i];
    end
  endgenerate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
