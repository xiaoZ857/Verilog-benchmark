
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0001; // Reset the counter to 0
    end else if (slowena) begin
        q <= q + 1; // Increment the counter when slowena is high
    end
end

always @(posedge clk) begin
    if (!slowena && !(q[3])) begin // Check if not paused and the current value is 9
        q <= 4'b0001; // Reset the counter to 0 when reaching 9
    end
end

// Use always @(posedge clk) instead of always @(negedge clk) for positive edge-triggered signals

// Add timescale directive before module definition
`timescale 1ns / 1ps

endmodule
