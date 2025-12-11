
module TopModule (
  input in1,
  input in2,
  output logic out
);
 ```verilog
always @(posedge clk) begin
    assign out = ~(in1 | in2);
end
endmodule

// VERILOG-EVAL: abnormal backticks count
