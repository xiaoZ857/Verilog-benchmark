
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0001; // Reset the counter to 1
  end else begin
    if (q == 4'b1001) begin // If we reach 10, wrap around to 1
      q <= 4'b0001;
    end else begin // Otherwise, increment the counter
      q <= q + 1'b1;
    end
  end
end

// VERILOG-EVAL: endmodule not found
