
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
  end else if (load) begin
    // Load the data into the shift register when only load is asserted or both load and ena are asserted
    q <= data;
  end else if (ena && !load) begin
    // Shift right when only ena is asserted and load is not asserted
    q[3:1] <= q[2:0];
    q[0] <= 4'b0; // q[0] is shifted out and disappears
  end
end

// VERILOG-EVAL: abnormal backticks count
