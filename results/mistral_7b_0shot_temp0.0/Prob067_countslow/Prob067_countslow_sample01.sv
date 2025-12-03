

module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0001; // Reset the counter to 0
    end else if (slowena) begin
        q <= q + 1; // Increment the counter when slowena is high
    end
end

// VERILOG-EVAL: endmodule not found
