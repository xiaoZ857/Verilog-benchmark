
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
  // Use a ripple-carry population count.  This is simple to implement
  // but not the most efficient.  For a 255-bit input, a more
  // efficient implementation (e.g., using tree-based reduction)
  // would be preferable for performance.

  wire [254:0] carry_out;

  // First stage:  Each bit contributes to a carry if it's 1.
  assign carry_out[0] = in[0];
  genvar i;
  generate
    for (i = 1; i < 255; i = i + 1) begin: ripple_carry_stage
      assign carry_out[i] = in[i] ^ carry_out[i-1];
    end
  endgenerate

  // Second stage:  Sum the carries to get the population count.
  reg [7:0] sum;

  always @(posedge clk) begin
    sum <= 0;
  end

  always @(posedge clk) begin
    for (i = 0; i < 255; i = i + 1) begin
      sum <= sum + carry_out[i];
    end
  end

  assign out = sum;

endmodule
