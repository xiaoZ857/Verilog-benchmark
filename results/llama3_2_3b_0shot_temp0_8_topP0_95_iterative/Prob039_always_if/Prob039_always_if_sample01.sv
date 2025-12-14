
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);
// Assign statement version
assign out_assign = sel_b1 && sel_b2 ? b : a;

// Always block with if statement version
always @(*)
    if ((sel_b1 && sel_b2))
        out_always <= b;
    else
        out_always <= a;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
