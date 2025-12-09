
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
// Define the module and its inputs/outputs
module DFlipFlop_8Bit(
  // Input: Clock signal, resets the flip-flops on rising edge
  input clk,
  
  // Input: Data to be stored in the flip-flop (7-bit data)
  input [7:0] d,
  
  // Input: Synchronous reset for all flip-flops (active high)
  input reset,
  
  // Output: The state of each flip-flop (8-bit Q output)
  output reg [7:0] q[7]
);

// D Flip-Flop 8-bit implementation
assign q[0] = d[7];
assign q[1] = d[6];
assign q[2] = d[5];
assign q[3] = d[4];
assign q[4] = d[3];
assign q[5] = d[2];
assign q[6] = d[1];
assign q[7] = d[0];

// Synchronous reset for all flip-flops
always @(posedge clk) begin
  if (reset) begin
    // Reset values are given in hexadecimal format, so we convert them to decimal
    $equation $q[0] = int(34 & (8 * 2 ^ 4));
    $equation $q[1] = int(34 >> 4);
    $equation $q[2] = int(34 >> 8);
    $equation $q[3] = int(34 >> 12);
    $equation $q[4] = int(34 >> 16);
    $equation $q[5] = int(34 >> 20);
    $equation $q[6] = int(34 >> 24);
    $equation $q[7] = int(34 >> 28);
  end else begin
    // Update flip-flop states based on the input data (D)
    $equation q[0] = d[7];
    $equation q[1] = d[6];
    $equation q[2] = d[5];
    $equation q[3] = d[4];
    $equation q[4] = d[3];
    $equation q[5] = d[2];
    $equation q[6] = d[1];
    $equation q[7] = d[0];
  end
end

// Instantiate the DFlipFlop_8Bit module for each flip-flop in series
DFlipFlop_8Bit DFF_0 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[7])
);

DFlipFlop_8Bit DFF_1 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[6])
);

DFlipFlop_8Bit DFF_2 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[5])
);

DFlipFlop_8Bit DFF_3 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[4])
);

DFlipFlop_8Bit DFF_4 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[3])
);

DFlipFlop_8Bit DFF_5 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[2])
);

DFlipFlop_8Bit DFF_6 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[1])
);

DFlipFlop_8Bit DFF_7 (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q[0])
);

// VERILOG-EVAL: endmodule not found
