
module TopModule (
  input clk,
  input x,
  output z
);
// Define XOR, AND, OR gates and assign port names
xor #1 u_xor (.a(x), .b(d_xor[0]), .o(d_xor[1].o));
and u_and (.a(x), .b(!d_and[0]).o, .o(d_and[1].o));
or  u_or  (.a(x), .b(!d_or [0]).o, .o(d_or [1].o));

// Define NOR gate and output
nor #1 u_nor (.a(d_xor[1].i), .b(d_and[1].i), .c(d_or [1].i), .o(z));

always @(posedge clk) begin
  d_xor[0] <= x;
  d_and[0] <= !d_and[1].o;
  d_or [0] <= !d_or [1].o;
end

// VERILOG-EVAL: endmodule not found
