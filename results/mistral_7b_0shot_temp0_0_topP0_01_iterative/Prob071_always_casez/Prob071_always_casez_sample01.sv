
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
always @(posedge clk) begin
  pos <= 3'bz; // Initialize output to zero

  if (in[0])
    pos <= 3'b010; // Output 0 if bit[0] is high

  for (int i = 1; i < 8; i++) begin
    if (in[i] && !in[(i-1)])
      pos <= {pos[1], pos[2], i+3'b1}; // Output the index of the first bit that is high
  end
end

// Add clock enable and reset signals as needed
reg clk_en, reset;
assign clk_en = your_clock_enable_signal;
assign reset = your_reset_signal;

always @(posedge clk) if (clk_en && !reset) begin
  pos <= 3'bz; // Reset output to zero
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

// Module body code ends here
endmodule
