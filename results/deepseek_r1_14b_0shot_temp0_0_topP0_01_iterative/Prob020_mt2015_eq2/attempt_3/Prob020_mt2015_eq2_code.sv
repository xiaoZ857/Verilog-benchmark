
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
reg z_reg;
always @* begin
  if (A == B) 
    z_reg = 1;
  else 
    z_reg = 0;
end
assign z = z_reg;

// VERILOG-EVAL: abnormal backticks count
