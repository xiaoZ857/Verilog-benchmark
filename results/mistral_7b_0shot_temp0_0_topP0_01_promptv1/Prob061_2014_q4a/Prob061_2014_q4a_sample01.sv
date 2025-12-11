
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
 ```verilog
always @(posedge clk) begin
    if (L)
        Q <= R;
    else if (E)
        Q <= {Q[1:0], w}; // concatenate Q[1:0] and w for shifting
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
