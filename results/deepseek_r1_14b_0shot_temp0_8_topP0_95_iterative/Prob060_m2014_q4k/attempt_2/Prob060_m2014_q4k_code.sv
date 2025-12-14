
// timescale should be placed at the top of the file before any modules
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input resetn,  // Active-low reset
  input in,
  output out
);

  // Four D flip-flops for the shift register stages
  wire q1, q2, q3, q4;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
      q4 <= 0;
    end else begin
      q1 <= in;
      q2 <= q1;
      q3 <= q2;
      q4 <= q3;
    end
  end

  // The output is the final stage of the shift register
  assign out = q4;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
