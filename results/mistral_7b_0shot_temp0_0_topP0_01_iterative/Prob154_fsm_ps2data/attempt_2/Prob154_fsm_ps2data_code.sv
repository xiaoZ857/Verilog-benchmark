
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
module MessageFinder (
  input clk,
  input [7:0] in,
  input reset,
  output reg [2:0] state,
  output reg done
);

// Move timescale directive outside of the module definition
`timescale 1ns / 1ps

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    done <= 0;
  end else if (state === 0 && in[3]) begin
    state <= 1; // Start of message detected
  end else if (state === 1) begin
    state <= state + 1; // Move to next state
  end else if (state === 3) begin
    done <= 1; // Signal done after receiving third byte
    state <= 0; // Reset state for next message
  end
end

module DataPath (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

wire [7:0] byte1, byte2, byte3;
assign byte1 = in;
assign byte2 = in[8];
assign byte3 = in[16];

MessageFinder messageFinder (clk, in, reset, state, done);
always @(posedge clk) begin
  if (done) begin
    out_bytes <= {byte1, byte2, byte3}; // Output the received message when done is asserted
  end else begin
    out_bytes <= 8'bx; // Don't care at other times
  end
end

// VERILOG-EVAL: endmodule not found
