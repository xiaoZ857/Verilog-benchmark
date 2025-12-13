
module TopModule (
  input clk,
  input d,
  output reg q
);

always @ (posedge clk)
    q <= d;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
