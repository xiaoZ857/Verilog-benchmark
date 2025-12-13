
module TopModule (
  input d,
  input ena,
  output logic q
);
always_ff @(posedge ena or posedge d) begin
  if (ena) begin
    q <= d;
  end
end

// VERILOG-EVAL: abnormal backticks count
