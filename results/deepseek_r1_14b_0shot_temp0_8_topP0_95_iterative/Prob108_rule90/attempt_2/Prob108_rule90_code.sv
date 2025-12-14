
// timescale directive should be placed at the beginning of the file
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

reg [511:0] q_next;

always @* begin
  // Initialize next state with all zeros (assuming boundaries are off)
  q_next = 0;
  
  for (int i = 0; i < 512; i++) begin
    // Get left and right neighbors, treating boundaries as 0
    bit left = (i == 0) ? 0 : q[i - 1];
    bit right = (i == 511) ? 0 : q[i + 1];
    
    // Apply Rule 90: next state is XOR of left and right neighbors
    q_next[i] = left ^ right;
  end
end

// Clock enable logic to control updates based on load signal
always @(posedge clk) begin
  if (load) 
    q <= data;
  else 
    q <= q_next;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
