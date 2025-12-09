
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  always @(posedge clk) begin
    if ((a & c) | (b & d)) begin
      out = 1;
    end else begin
      out = 0;
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
