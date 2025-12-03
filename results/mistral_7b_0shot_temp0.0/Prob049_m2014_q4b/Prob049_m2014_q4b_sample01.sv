

module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

 ```verilog
always @(posedge clk or negedge ar)
begin
  if (!ar)
    q <= d;
  else
    q <= ~q; // reset value is complement of current Q
end

assign q_bar = !q; // providing q_bar as an additional output

endmodule

// VERILOG-EVAL: abnormal backticks count
