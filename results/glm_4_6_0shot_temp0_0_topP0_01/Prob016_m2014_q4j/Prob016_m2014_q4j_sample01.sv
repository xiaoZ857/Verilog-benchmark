
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Internal wires for carry signals between full adders
  wire c0, c1, c2, c3;
  
  // Full adder for bit 0 (LSB)
  xor sum0_xor1(sum0_xor1_out, x[0], y[0]);
  xor sum0_xor(sum[0], sum0_xor1_out, 1'b0);  // cin = 0 for LSB
  and cout0_and1(cout0_and1_out, x[0], y[0]);
  and cout0_and2(cout0_and2_out, sum0_xor1_out, 1'b0);
  or cout0_or(c0, cout0_and1_out, cout0_and2_out);
  
  // Full adder for bit 1
  xor sum1_xor1(sum1_xor1_out, x[1], y[1]);
  xor sum1_xor(sum[1], sum1_xor1_out, c0);
  and cout1_and1(cout1_and1_out, x[1], y[1]);
  and cout1_and2(cout1_and2_out, sum1_xor1_out, c0);
  or cout1_or(c1, cout1_and1_out, cout

// VERILOG-EVAL: endmodule not found
