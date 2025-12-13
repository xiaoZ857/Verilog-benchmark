
module TopModule (
  input clk,
  input a,
  output reg q
);
always @(posedge clk) begin
  reg clk_prev; // Register to hold the previous value of clk
  always_ff @(posedge clk) begin
    clk_prev <= clk; // Update clk_prev at every clock cycle
  end

  if (a == 1'b1 && clk_prev == 1'b0) begin
    q <= ~q; // Toggle q when a is high and there is a rising edge on clk
  end
end

endmodule
