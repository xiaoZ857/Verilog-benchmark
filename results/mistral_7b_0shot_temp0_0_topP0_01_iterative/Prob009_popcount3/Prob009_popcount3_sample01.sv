
// Calculate timescale outside of any module definition
`timescale ins/ns /1 ns

module TopModule (
  input [2:0] in,
  output [1:0] out
);

always @(posedge clk) begin
  // Calculate partial population counts for each bit position
  pcount_msb [3:0] = in >> ([2:0]*3);
  pcount_lsb = in & 1'b1;

  // Calculate partial population count for middle bit position
  pcount_mid [2:0] = (in >> 1) & ([2:0]);
  pcount_mid[1] += pcount_lsb;

  out[0] <= pcount_msb[2];
  out[1] <= pcount_msb[1] + pcount_mid[1];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
