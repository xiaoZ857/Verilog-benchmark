
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [5:0] out_not
);

always @(posedge clk) begin
  out_or_bitwise <= a | b; // Bitwise OR
  out_or_logical <= a || b; // Logical OR

  // Invert each bit of 'a' and 'b' separately
  assign out_not[2] = ~a[2];
  assign out_not[1] = ~a[1];
  assign out_not[0] = ~a[0];

  assign out_not[5] = ~b[2];
  assign out_not[4] = ~b[1];
  assign out_not[3] = ~b[0];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
