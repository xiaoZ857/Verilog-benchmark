
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
 ```verilog
always @(posedge clk) begin
    assign z = (A[1] == B[1]) && (A[0] == B[0]);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
