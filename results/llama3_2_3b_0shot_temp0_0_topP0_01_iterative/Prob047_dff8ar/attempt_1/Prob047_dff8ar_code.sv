
// Create 8 D flip-flops with active high asynchronous reset
module TopModule (
  input clk, // Positive clock signal
  input [7:0] d, // Data to be written into the DFFs
  input areset, // Active high asynchronous reset
  output reg [7:0] q // Output of the DFFs
);

// Create 8 D flip-flops with active high asynchronous reset
DFlipFlop dff[8];

// Instantiate each DFF
for (int i = 0; i < 8; i++) begin : DFF_0_iup
  DFlipFlop dff[i];
end

// Connect the clock and data inputs to the DFFs
assign clk_dff[0:7] = clk;
assign d_dff[0:7] = d;

// Create a single asynchronous reset signal for all DFFs
assign areset_dff = areset;

// Connect the output of each DFF to the q output
for (int i = 0; i < 8; i++) begin : DFF_0_iup
  assign q[i] = dff[i].q;
end

// Create an active high asynchronous reset for all DFFs
assign areset_dff = !areset;

// Instantiate the DFlipFlop module
DFlipFlop dff_0 (
  .clk(clk),
  .d(d[7]),
  .q(dff[0].q)
);

// Instantiate the DFlipFlop module for each of the remaining 7 DFFs
for (int i = 1; i < 8; i++) begin : DFF_0_iup
  DFlipFlop dff[i] (
    .clk(clk),
    .d(d[7+i]),
    .q(dff[i].q)
  );
end

// Instantiate the DFlipFlop module for each of the remaining 7 DFFs
for (int i = 0; i < 8; i++) begin : DFF_0_iup
  assign d_dff[i] = d[7+i];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
