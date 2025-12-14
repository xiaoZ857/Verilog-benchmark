
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

  // Implement 8 D flip-flops using a generate statement
  generate
    genvar i;
    for (i = 0; i < 8; i++) : d_ff_gen
      always @(posedge clk) 
        q[i] <= d[i];
  endgenerate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
