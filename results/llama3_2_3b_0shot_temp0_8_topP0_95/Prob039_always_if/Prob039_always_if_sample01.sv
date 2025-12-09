
// Using assign statements
module TopModule(
  input a, 
  input b, 
  input sel_b1, 
  input sel_b2,
  output out_assign,
  output reg out_always
);

assign out_assign = (sel_b1 && sel_b2) ? b : a;
assign out_always = (sel_b1 && sel_b2) ? b : a;

// Using procedural if statement
module TopModule(
  input a, 
  input b, 
  input sel_b1, 
  input sel_b2,
  output out_assign,
  output reg out_always
);

reg out_assign_reg;
reg out_always_reg;

always @(posedge clk) begin
  out_assign_reg = (sel_b1 && sel_b2) ? b : a;
end

assign out_assign = out_assign_reg;
assign out_always = out_always_reg;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
