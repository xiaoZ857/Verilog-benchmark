
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);
always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    out_assign <= a;
    out_always <= a;
  end else if (sel_b1 && sel_b2) begin
    out_assign <= b;
    out_always <= b;
  end
  out_always <= out_assign; // Assign the value of out_assign to out_always
end

endmodule
