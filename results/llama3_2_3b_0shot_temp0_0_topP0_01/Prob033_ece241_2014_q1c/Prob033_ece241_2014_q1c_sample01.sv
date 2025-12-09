

module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

assign s = {a[7], ~a[6] + ~b[6] + (~a[5] & ~b[5])};
assign overflow = (a[7] == 1) && (b[0] == 1);
endmodule

// VERILOG-EVAL: abnormal backticks count
