
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
always @(posedge clk) begin
    if (in[3] == 1)
        pos <= 2'b10; // If bit 3 is set, output 2
    else if (in[2] == 1 && in[3] == 0)
        pos <= 2'b11; // If bit 2 is set and bit 3 is not set, output 3
    else if (in[1] == 1 && in[2] == 0 && in[3] == 0)
        pos <= 2'b01; // If bit 1 is set and bits 2 and 3 are not set, output 1
    else if (in[0] == 1 && in[1] == 0 && in[2] == 0 && in[3] == 0)
        pos <= 2'b00; // If bit 0 is set and bits 1, 2, and 3 are not set, output 0
    else
        pos <= 2'bx; // To avoid latch-up, assign an undefined value when no input bits are set
end

// VERILOG-EVAL: endmodule not found
