
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);
// Assign statement implementation
assign out_assign = (sel_b1 && sel_b2) ? b : a;

// Always block implementation using logic gates
always @(posedge clk)
begin
  if ((sel_b1 && sel_b2)) then
    out_always <= b;
  else
    out_always <= a;
end

// Alternative: Using procedural if statement
always @(posedge clk)
if (sel_b1 && sel_b2) then
  out_always <= b;
else
  out_always <= a;

// VERILOG-EVAL: endmodule not found
