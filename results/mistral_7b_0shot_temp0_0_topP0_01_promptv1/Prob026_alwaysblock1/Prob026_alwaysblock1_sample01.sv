
module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);
 ```verilog
assign out_assign = a & b;

always @* begin
    out_alwaysblock = a & b;
end

endmodule

// VERILOG-EVAL: abnormal backticks count
