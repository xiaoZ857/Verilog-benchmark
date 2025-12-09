
module TopModule (
  input clk,
  input d,
  output reg q
);

  always @(posedge clk) begin
    q <= d;
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
