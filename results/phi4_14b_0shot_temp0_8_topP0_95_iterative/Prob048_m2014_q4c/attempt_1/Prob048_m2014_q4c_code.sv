
module TopModule (
  input wire clk,
  input wire d,
  input wire r,
  output reg q
);

  always @(posedge clk or posedge r) begin
    if (r) begin
      // Synchronous reset: when r is high, set q to 0
      q <= 1'b0;
    end else begin
      // D flip-flop behavior on the rising edge of the clock
      q <= d;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
