
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
 ```verilog
always @(posedge clk or negedge r) begin
    if (r)
        q <= 1'b0;
    else
        q <= d;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
