
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
always @(posedge clk) begin
    pos <= 3'bz; // initialize output to zero

    for (integer i = 7; i >= 0; i--) begin
        if (in[i]) begin // check each bit from the most significant bit
            pos <= i + 1'b0; // update the output with the index of the first set bit (zero-based to one-based)
            break; // exit the loop after finding the first set bit
        end
    end
end

// Clock and reset inputs, replace 'clk' and 'reset' with your actual clock and active-low reset signals
input clk, reset;

// Add the clock and reset pins to the module port list
output reg [2:0] pos, input clk, reset;

// Optional: Add a reset signal if needed
always @(posedge reset) begin
    if (reset) begin
        pos <= 3'bz; // set output to zero on reset
    end
end

// The `timescale` directive should be outside the module definition.
// I have moved it here for better readability, but you can place it elsewhere in your Verilog file if needed.
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
