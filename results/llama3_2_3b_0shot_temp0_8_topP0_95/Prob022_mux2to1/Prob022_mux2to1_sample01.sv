
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
  
  always @(*)
    assign out = (sel == 0) ? a : b;
endmodule

// VERILOG-EVAL: errant inclusion of module definition
