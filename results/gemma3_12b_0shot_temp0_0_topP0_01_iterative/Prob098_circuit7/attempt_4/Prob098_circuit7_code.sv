
module TopModule (
  input clk,
  input a,
  output reg q
);
  reg q_next;

  always @(posedge clk) begin
    if (a == 1) begin
      q <= ~q;
    end else begin
      q <= q;
    end
  end

// VERILOG-EVAL: endmodule not found
