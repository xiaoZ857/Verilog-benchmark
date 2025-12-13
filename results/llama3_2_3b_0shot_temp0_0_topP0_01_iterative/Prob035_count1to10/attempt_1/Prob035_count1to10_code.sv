
// Define the module parameters
param DECIMAL_COUNT = 10;

// Define the module inputs and outputs
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

// Create a register to store the current count value
reg [DECIMAL_COUNT-1:0] count;

// Initialize the count to 0 (since we're counting from 1)
initial begin
  count = 0;
end

// Define the module's behavior
always @(posedge clk) begin
  // If reset is active high, reset the counter to 0
  if (reset && q == 0) begin
    count <= 0;
    q <= 1'b0;
  end else begin
    // Increment the count and wrap around when it reaches 10
    count <= count + 1;
    q <= count[3:0];
  end
end

// Initialize the output to 0 (since we're counting from 1)
initial begin
  q <= 1'b0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
