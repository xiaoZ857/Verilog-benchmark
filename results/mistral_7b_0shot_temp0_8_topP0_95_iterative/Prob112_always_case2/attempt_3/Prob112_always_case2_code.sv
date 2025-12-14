
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
always @(posedge clk) begin
    if (in[3] == 1)
        pos <= 2'b10; // If bit 3 is set, output 2
    else if (in[2] == 1)
        pos <= 2'b01; // If bit 2 is set, output 1
    else if (in[1] == 1)
        pos <= 2'b00; // If bit 1 is set, output 0
    else if (in[0] == 1)
        pos <= 2'b11; // If bit 0 is set, output 3
    else
        pos <= 2'bx; // To avoid latch-up, assign an undefined value when no input bits are set
end

// timescale directive should be outside the module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
