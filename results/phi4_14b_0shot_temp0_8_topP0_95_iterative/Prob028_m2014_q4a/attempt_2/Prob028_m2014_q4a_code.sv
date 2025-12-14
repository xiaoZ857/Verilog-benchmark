
module TopModule (
  input d,
  input ena,
  output logic q
);
  // Declare the clk input
  input wire clk;

  // Always block triggered on the positive edge of clk or when enable changes
  always @(posedge clk or ena) begin
    if (ena) begin
      q <= d;  // Capture the value of 'd' at 'q' when 'ena' is high
    end
    else begin
      q <= q;  // Hold the current value of 'q'
    end
  end

endmodule
