
module TopModule (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);
assign out[24] = ~a ^ a;
assign out[23] = ~a ^ b;
assign out[22] = ~a ^ c;
assign out[21] = ~a ^ d;
assign out[20] = ~a ^ e;
assign out[19] = ~b ^ a;
assign out[18] = ~b ^ b;
assign out[17] = ~b ^

// VERILOG-EVAL: endmodule not found
