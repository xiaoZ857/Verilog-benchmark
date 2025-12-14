
module TopModule (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);
always @(*) begin
    // Concatenate inputs and append two '1' bits at the end.
    wire [31:0] combined = {a, b, c, d, e, f, 2'b11};

    // Assign slices of the concatenated vector to outputs
    w = combined[31:24];  // Most significant 8 bits
    x = combined[23:16];
    y = combined[15:8];
    z = combined[7:0];    // Two '1' bits should be here as LSBs
end

endmodule
