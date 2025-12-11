
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
assign z = !((x == 0) & ((a) == 0));

always @(posedge clk or negedge areset)
    assign a = (areset && ~x);
    assign b = (areset || x);

// VERILOG-EVAL: endmodule not found
