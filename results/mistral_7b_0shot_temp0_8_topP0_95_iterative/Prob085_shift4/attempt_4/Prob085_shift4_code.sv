
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (!areset) begin
    q <= 4'b0; // Reset the shift register to zero
  end else if (load && ena) begin // Change here
    q <= data; // Load data when both load and ena are asserted
  end else if (ena) begin // Shift right otherwise
    q[3:1] <= q[2:0]; // Shift all bits except the first one
    q[0] <= 0; // The first bit is reset
  end
end

// VERILOG-EVAL: abnormal backticks count
