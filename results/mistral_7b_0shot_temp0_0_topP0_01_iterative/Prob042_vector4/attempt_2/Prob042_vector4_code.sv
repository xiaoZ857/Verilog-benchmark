
module TopModule (
  input [7:0] in,
  output [31:0] out
);
always @(posedge clk) begin
  // Create a helper variable to store the sign bit (msb) of the input
  reg [7] sign_bit = in;

  // Shift the sign bit left for 24 times to replicate it
  assign out[31:8] = sign_bit << (24 - 1);

  // Copy the original input to the lower 8 bits of the output
  assign out[7] = in;
end

// VERILOG-EVAL: endmodule not found
