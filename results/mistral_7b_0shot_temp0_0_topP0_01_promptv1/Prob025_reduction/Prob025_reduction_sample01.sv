
module TopModule (
  input [7:0] in,
  output parity
);
 ```verilog
always @(posedge clk) begin
    parity <= ^in; // XOR operation for even parity
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
