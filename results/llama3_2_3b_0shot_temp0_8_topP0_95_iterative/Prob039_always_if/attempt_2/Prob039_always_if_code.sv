
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);
// Select the output based on the values of sel_b1 and sel_b2 using assign statement
assign out_assign = (sel_b1 && sel_b2) ? b : a;

// Select the output based on the values of sel_b1 and sel_b2 using always block with if statement
always @(*)
    if ((sel_b1 && sel_b2))
        out_always <= b;
    else
        out_always <= a;

// VERILOG-EVAL: endmodule not found
