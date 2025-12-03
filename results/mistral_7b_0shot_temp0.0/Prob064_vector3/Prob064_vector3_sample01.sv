

module TopModule (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);

always @(posedge clk) begin
    w <= {a, b, c, d, e, f, 1'b1, 1'b1}; // Concatenate input vectors and add two 1 bits at the end
    x <= {b, c, d, e, f}[0]; // Extract first 5 bits from concatenated vector
    y <= {c, d, e, f}[0]; // Extract second 5 bits from concatenated vector
    z <= {d, e, f}[0]; // Extract third 5 bits from concatenated vector
end

// VERILOG-EVAL: endmodule not found
