
// Set timescale at the beginning of the file
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    // Calculate next state for each cell based on Rule 90
    for (int i = 0; i < 512; i++) begin
      // Left neighbor is i-1, right neighbor is i+1
      // Boundary conditions: q[-1] and q[512] are considered 0
      int left = (i == 0) ? 0 : q[i - 1];
      int right = (i == 511) ? 0 : q[i + 1];
      
      // Rule 90: next state is XOR of left and right neighbors
      q[i] <= (left ^ right);
    end
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
