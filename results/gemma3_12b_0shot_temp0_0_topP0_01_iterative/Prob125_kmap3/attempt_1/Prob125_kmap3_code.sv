
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  always @(a, b, c, d) begin
    if ((a == 0 && b == 0 && c == 0 && d == 0) ||
        (a == 0 && b == 0 && c == 1 && d == 0) ||
        (a == 0 && b == 0 && c == 1 && d == 1) ||
        (a == 0 && b == 0 && c == 1 && d == 0) ||
        (a == 0 && b == 0 && c == 1 && d == 1) ||
        (a == 0 && b == 0 && c == 1 && d == 0) ||
        (a == 0 && b == 0 && c == 1 && d == 1) ||
        (a == 0 && b == 0 && c == 1 && d == 0) ||
        (a == 0 && b == 0 && c == 1 && d == 1) ) begin
      out = 1;
    end else begin
      out = 0;
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
