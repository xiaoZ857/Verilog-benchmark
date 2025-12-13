
// Create 8 D flip-flops with active high synchronous reset
module TopModule (
  input clk, // Positive clock signal
  input [7:0] d, // Data to be written into the flip-flop
  input reset, // Active high synchronous reset
  output reg [7:0] q // Output of the D flip-flop
);

// Create 8 DFFs with active high synchronous reset
DFF_8 dffs (
  .clk(clk),
  .d(d),
  .reset(reset),
  .q(q)
);

endmodule

// Define a module for each DFF
module DFF_8(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

reg [7:0] q;

always @(posedge clk) begin
  if (reset) begin
    // Reset the flip-flop to 0x34
    q <= 0x34;
  end else begin
    // Write data into the flip-flop on the rising edge of clock
    q <= d;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
