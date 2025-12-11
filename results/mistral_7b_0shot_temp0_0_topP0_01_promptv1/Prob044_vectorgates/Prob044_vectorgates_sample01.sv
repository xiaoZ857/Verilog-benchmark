
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
 ```verilog
assign out_or_bitwise = a | b;
always @(*) out_or_logical = a || b;

reg [5:0] out_not_temp;
always @(posedge clk) begin
  out_not_temp[2:0] = ~a;
  out_not_temp[5:3] = ~b;
  out_not = out_not_temp;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
