

module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  assign out_both[0] = 0;
  genvar i;
  generate
    for (i = 1; i < 99; i = i + 1) begin: both_loop
      assign out_both[i] = in[i] & in[i-1];
    end
  endgenerate

  assign out_any[0] = 0;
  generate
    for (i = 1; i < 100; i = i + 1) begin: any_loop
      assign out_any[i] = in[i] | in[(i-1 + 100) % 100];
    end
  endgenerate

  generate
    for (i = 0; i < 100; i = i + 1) begin: diff_loop
      assign out_different[i] = in[i] != in[(i-1 + 100) % 100];
    end
  endgenerate

// VERILOG-EVAL: endmodule not found
