

module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

always @(posedge clk or ar)
begin
  if (ar)
    q <= 0;
  else
    q <= d;
end

// VERILOG-EVAL: endmodule not found
