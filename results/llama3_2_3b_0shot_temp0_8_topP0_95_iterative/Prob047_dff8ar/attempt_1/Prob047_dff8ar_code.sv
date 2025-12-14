
// Define the Top Module
module TopModule (
  // Clock and Reset Inputs
  input clk,  // Positive Edge Triggered Clock
  input areset,  // Active High Asynchronous Reset Signal

  // Data Input
  input [7:0] d,

  // Q Output of D Flip-Flops (Regized)
  output reg [7:0] q
);

// Define the internal D Flip-Flop modules
reg [7:0] q[8];
reg [7:0] q_prev[8];

// Asynchronous Reset for all DFFs
always @(posedge clk or negedge areset) begin
  // If asynchronous reset is asserted, set all Q outputs to 0
  if (areset) begin
    #10  // Allow some setup time
    $display("Resetting module");
  end else if (clk == 1'b1) begin
    // On the next positive clock edge, update the Q output of each DFF
    for (int i = 0; i < 8; i++) begin
      q[i] = d[i];
      q_prev[i] = q[i]; // Store the previous state in q_prev
    end
  end
end

// Update the output signals
assign q = q[7:0]; // Assign the lower bits of q as the output signal

// Optional: Add a testbench to verify the module's functionality
module TopModuleTestbench();

  reg [7:0] d;  // Test Data Input
  wire q;     // Q Output Signal

  RegFile #(.clk clk, .areset areset) u_regfile(
    .d(d),
    .q(q)
  );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
