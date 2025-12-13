
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always_comb begin
  out = ((~a | c) & (~b | d)) | ((a & c) | (b & d));
end

// Adding missing semicolon at the end of the always_comb block
out = ((~a | c) & (~b | d)) | ((a & c) | (b & d));
// Corrected the logic to match the given Karnaugh map

endmodule
