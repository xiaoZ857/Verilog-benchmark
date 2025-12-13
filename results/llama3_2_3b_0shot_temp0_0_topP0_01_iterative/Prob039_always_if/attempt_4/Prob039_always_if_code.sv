
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
  out_always <= ((sel_b1 && sel_b2) ? b : a);
end

// Alternative: Using logic gates directly in the always block
always @(posedge clk)
out_always <= (sel_b1 & sel_b2) ? b : a;

// VERILOG-EVAL: endmodule not found
