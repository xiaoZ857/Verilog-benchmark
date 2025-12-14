
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  if (a) begin
    // Increment the counter when 'a' is high.
    if (q === 4'b1110) begin
      // If the counter reaches 4, reset it to 0.
      q <= 3'b000;
    end else begin
      // Otherwise, increment the counter.
      q <= q + 1;
    end
  end else begin
    // When 'a' is low, the counter remains unchanged.
    if (q === 4'b0000) begin
      // If the counter is initially at 0, it will count up to 1 after reset.
      q <= 4'b0001;
    end
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
