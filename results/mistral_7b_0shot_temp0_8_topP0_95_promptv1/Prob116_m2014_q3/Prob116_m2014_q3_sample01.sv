
module TopModule (
  input [4:1] x,
  output logic f
);
 ```verilog
always @(posedge clk) begin
    if (x[3] & ~x[2] & ~x[1])
        f = x[4];
    else if (~x[3] & x[2] & ~x[1])
        f = ~x[4];
    else if (x[3] & x[2] & x[1])
        f = 1'b0;
    else
        f = 1'b1;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
