
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output reg out_assign,
  output reg out_always
);

// Mux using assign statements
always @(posedge clk) begin
  if (sel_b1 && sel_b2)
    out_assign = b;
  else
    out_assign = a;
end

// Mux using procedural if statement
always @(posedge clk) begin
  if (sel_b1 && sel_b2)
    out_always <= b;
  else
    out_always <= a;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
