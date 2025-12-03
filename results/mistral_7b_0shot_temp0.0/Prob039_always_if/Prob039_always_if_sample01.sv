

module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);

always @(posedge clk) begin
  if (sel_b1 && sel_b2)
    out_assign <= b;
  else
    out_assign <= a;
end

assign out_always = out_assign;

// VERILOG-EVAL: abnormal backticks count
