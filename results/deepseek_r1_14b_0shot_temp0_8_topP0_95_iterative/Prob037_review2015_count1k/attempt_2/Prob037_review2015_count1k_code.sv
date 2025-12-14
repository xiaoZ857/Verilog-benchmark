
// Set simulation timescale (commonly used for digital designs)
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

  // Internal counter to track the value
  reg [9:0] count;

  // Clocked process that updates the counter and handles reset
  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
    end else begin
      if (count < 1000) begin
        count <= count + 1;
      end else begin
        count <= 0;
      end
    end
  end

  // Output the current count value
  assign q = count;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
