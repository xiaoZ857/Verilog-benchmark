
module TopModule (
  input [15:0] in,
  output [7:0] out_hi,
  output [7:0] out_lo
);
always @(posedge clk) begin
  out_hi <= in[15:8];
  out_lo <= in[7:0];
end

// Timescale directive should be outside the module definition
`timescale 1ns / 1ps

// Add clock input and synchronization if needed
// (clk is assumed to be a posedge-triggered reset-asynchronous flip-flop)
// e.g.,
// input wire clk, reset;
// always @(posedge clk or negedge reset) begin
//   if (!reset) begin
//     out_hi <= 8'b0;
//     out_lo <= 8'b0;
//   end else begin
//     out_hi <= in[15:8];
//     out_lo <= in[7:0];
//   end
// end

endmodule
