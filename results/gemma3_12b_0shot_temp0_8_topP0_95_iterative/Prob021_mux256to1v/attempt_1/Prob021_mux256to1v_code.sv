
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // Calculate the starting index of the selected 4-bit input.
  // sel = 0 selects in[3:0] (index 0)
  // sel = 1 selects in[7:4] (index 4)
  // sel = 2 selects in[11:8] (index 8)
  // ...
  // sel = 31 selects in[1020:1017] (index 1020)
  // The starting index is sel * 4.

  assign out = in[(sel * 4) + 3 : (sel * 4)];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
