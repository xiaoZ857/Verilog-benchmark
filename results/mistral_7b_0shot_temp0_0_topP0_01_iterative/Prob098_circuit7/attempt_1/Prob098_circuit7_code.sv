
module TopModule (
  input clk,
  input a,
  output reg q
);

always @(posedge clk) begin
  if (a)
    q <= ~q;
end

initial begin
  // Reset initial state
  q <= 0;
  #5;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
