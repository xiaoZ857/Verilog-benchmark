
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
2'b10: begin
    // Arithmetic right shift by 1 bit
    q <= {q[63], q[62:0]};
end

2'b11: begin
    // Arithmetic right shift by 8 bits
    q <= {q[63], q[62:0] >> 8};
end

// VERILOG-EVAL: abnormal backticks count
