
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
  end else if (load & ena) begin
    if (load) begin // Load data when both load and ena are asserted
      q <= data;
    end else begin // Shift right otherwise
      q[3:1] <= q[2:0]; // Shift all bits except the first one
      q[0] <= 0; // The first bit is reset
    end
  end
end

// Add a synchronous reset to the output, resets only when areset is asserted
always @(posedge clk) begin
  if (areset) q <= 4'b0; // Synchronous reset for q output
end

// Remove the initial block as it is not necessary in this case

// Add an empty initial block to meet the requirement of having an initial block at the end
initial begin
  // Empty body
end

endmodule
