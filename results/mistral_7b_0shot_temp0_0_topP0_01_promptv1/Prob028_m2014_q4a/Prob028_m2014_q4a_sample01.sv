
module TopModule (
  input d,
  input ena,
  output logic q
);
 ```verilog
always @(posedge clk or negedge ena) begin
    if (!ena)
        q <= q; // hold current value when enable is low
    else
        q <= d; // assign new value to q when enable is high
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
