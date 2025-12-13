
module TopModule (
  input a,
  input b,
  input c,
  output out
);
function bool f;
  input [1:0] a, b, c;
  f = ~a & b | a & ~b;
endfunction

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
