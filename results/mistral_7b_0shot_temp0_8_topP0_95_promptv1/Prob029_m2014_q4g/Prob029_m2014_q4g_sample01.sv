
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
 ```verilog
always @(posedge clk) begin
    temp_xnor = ~(in1 ^ in2);
    out = temp_xnor ^ in3;
end

assign temp_xnor;
endmodule

// VERILOG-EVAL: abnormal backticks count
