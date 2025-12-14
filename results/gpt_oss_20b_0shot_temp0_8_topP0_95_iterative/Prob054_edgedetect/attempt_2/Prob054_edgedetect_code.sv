
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
  // Register to hold the previous value of the input vector
  reg [7:0] prev_in;

  // Register to latch the edge detection result (0→1 transition)
  reg [7:0] edge_flag;

  // Sequential logic: detect edges and output them one cycle later
  always @(posedge clk) begin
    // Detect 0→1 transition on each bit
    edge_flag <= (~prev_in) & in;

    // Output the detected edge one cycle after the transition
    pedge <= edge_flag;

    // Update previous input value for the next cycle
    prev_in <= in;
  end

endmodule
