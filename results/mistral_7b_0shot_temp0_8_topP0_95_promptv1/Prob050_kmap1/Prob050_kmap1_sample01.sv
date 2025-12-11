
module TopModule (
  input a,
  input b,
  input c,
  output out
);
 ```verilog
assign {out} = ~a & (!b | !c); // combinational logic with wire output
endmodule

// VERILOG-EVAL: abnormal backticks count
