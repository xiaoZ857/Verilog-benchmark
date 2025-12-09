

module TopModule (
  input [2:0] in,
  output [1:0] out
);

assign out = $count_mod(in);
endmodule

// VERILOG-EVAL: abnormal backticks count
