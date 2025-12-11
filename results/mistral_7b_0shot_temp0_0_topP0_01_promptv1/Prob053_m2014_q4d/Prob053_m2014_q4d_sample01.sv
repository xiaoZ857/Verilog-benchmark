
module TopModule (
  input clk,
  input in,
  output logic out
);
 ```verilog
always @(posedge clk) begin
    out <= ~out ^ in;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
