
function bool f;
  input [1:0] a, b, c;
  f = a & ~b | (~a & b) | (c & b);
endfunction

module TopModule (
  input a,
  input b,
  input c,
  output out
);
  assign out = f(a, b, c);
endmodule

// VERILOG-EVAL: errant inclusion of module definition
