
module TopModule (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);
always @(posedge clk) begin
  out[0] = ~e ^ e; // out[0] = e^e
  out[1] = ~e ^ d; // out[1] = e^d
  out[2] = ~d ^ e; // out[2] = d^e
  out[3] = ~d ^ c; // out[3] = d^c
  out[4] = ~d ^ a; // out[4] = d^a
  out[5] = ~c ^ d; // out[5] = c^d
  out[6] = ~c ^ b; // out[6] = c^b
  out[7] = ~c ^ a; // out[7] = c^a
  out[8] = ~b ^ c; // out[8] = b^c
  out[9] = ~b ^ a; // out[9] = b^a
  out[10] = ~a ^ c; // out[10] = a^c
  out[11] = ~a ^ d; // out[11] = a^d
  out[12] = ~d ^ a; // out[12] = d^a
  out[13] = ~b ^ a; // out[13] = b^a
  out[14] = ~c ^ b; // out[14] = c^b
  out[15] = ~d ^ c; // out[15] = d^c
  out[16] = ~e ^ d; // out[16] = e^d
  out[17] = ~e ^ c; // out[17] = e^c
  out[18] = ~c ^ e; // out[18] = c^e
  out[19] = ~d ^ e; // out[19] = d^e
  out[20] = ~b ^ e; // out[20] = b^e
  out[21] = ~a ^ e; // out[21] = a^e
  out[22] = ~e ^ a; // out[22] = e^a
  out[23] = ~a ^ b; // out[23] = a^b
  out[24] = ~a ^ c; // out[24] = a^c
end

// Add timescale directive outside the module definition
timescale 1ns / 1ps

endmodule
