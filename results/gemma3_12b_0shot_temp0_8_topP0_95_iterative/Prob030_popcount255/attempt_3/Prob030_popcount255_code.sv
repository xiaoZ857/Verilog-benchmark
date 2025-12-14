
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
  // Use a ripple-carry population count.  This is simple to implement
  // but not the most efficient.  For higher performance, consider a
  // tree-based implementation.

  reg [8:0] carry; // Need 8 bits for carry plus a carry-out
  reg [255:0] temp_in;

  integer i;

  always @(posedge clk) begin
    out = 0;
    carry[0] = 0; // Initialize carry
    for (i = 0; i < 255; i = i + 1) begin
      carry[i+1] = carry[i] | in[i]; // Propagate carry if input is 1
      out = out + carry[i+1];
    end
  end

endmodule
