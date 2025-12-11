
module TopModule (
  input [4:1] x,
  output logic f
);
 ```verilog
always @(posedge clk) begin
    if ((x[1] & ~x[2]) || (~x[3] & x[4]))
        f = 1'b1;
    else
        f = 1'b0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
