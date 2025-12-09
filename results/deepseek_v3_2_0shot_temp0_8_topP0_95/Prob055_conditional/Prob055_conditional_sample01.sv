
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
  // Combinational logic to find the minimum of four unsigned numbers
  always @(*) begin
    if (a <= b && a <= c && a <= d)
      min = a;
    else if (b <= c && b <= d)
      min = b;
    else if (c <= d)
      min = c;
    else
      min = d;
  end
endmodule
