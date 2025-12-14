
module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

// Using assign statement
assign out_assign = a & b;

// Using combinational always block
always @(posedge clk) begin
  if (a && b)
    out_alwaysblock <= 1'b1;
  else
    out_alwaysblock <= 1'b0;
end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
