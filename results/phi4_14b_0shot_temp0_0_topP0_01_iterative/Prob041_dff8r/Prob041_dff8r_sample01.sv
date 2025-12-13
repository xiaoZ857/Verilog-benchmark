
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
  // Declare internal registers for each D flip-flop
  reg q0, q1, q2, q3, q4, q5, q6, q7;

  always @(posedge clk) begin
    if (reset) begin
      // Synchronous reset: set all outputs to zero
      q0 <= 1'b0;
      q1 <= 1'b0;
      q2 <= 1'b0;
      q3 <= 1'b0;
      q4 <= 1'b0;
      q5 <= 1'b0;
      q6 <= 1'b0;
      q7 <= 1'b0;
    end else begin
      // On positive edge of clock, load input d into flip-flops
      q0 <= d[0];
      q1 <= d[1];
      q2 <= d[2];
      q3 <= d[3];
      q4 <= d[4];
      q5 <= d[5];
      q6 <= d[6];
      q7 <= d[7];
    end
  end

  // Assign the internal register values to output
  always @(*) begin
    q = {q7, q6, q5, q4, q3, q2, q1, q0};
  end

endmodule
