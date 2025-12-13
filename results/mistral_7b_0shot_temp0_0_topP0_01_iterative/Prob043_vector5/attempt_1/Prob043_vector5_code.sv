
module TopModule (
  input wire a,
  input wire b,
  input wire c,
  input wire d,
  input wire e,
  output [24:0] out
);

always @(posedge clk) begin
  out[0] = ~e & e; // out[0] = e^e
  out[1] = ~e & d; // out[1] = e^d
  out[2] = ~d & e; // out[2] = d^e
  out[3] = ~d & c; // out[3] = d^c
  out[4] = ~c & d; // out[4] = c^d
  out[5] = ~c & b; // out[5] = c^b
  out[6] = ~b & c; // out[6] = b^c
  out[7] = ~b & a; // out[7] = b^a
  out[8] = ~a & b; // out[8] = a^b
  out[9] = ~a & c; // out[9] = a^c
  out[10] = ~c & a; // out[10] = c^a
  out[11] = ~a & d; // out[11] = a^d
  out[12] = ~d & a; // out[12] = d^a
  out[13] = ~b & a; // out[13] = b^a
  out[14] = ~c & b; // out[14] = c^b
  out[15] = ~d & c; // out[15] = d^c
  out[16] = ~e & d; // out[16] = e^d
  out[17] = ~e & c; // out[17] = e^c
  out[18] = ~c & e; // out[18] = c^e
  out[19] = ~d & e; // out[19] = d^e
  out[20] = ~b & e; // out[20] = b^e
  out[21] = ~a & e; // out[21] = a^e
  out[22] = ~e & a; // out[22] = e^a
  out[23] = ~a & b; // out[23] = a^b
  out[24] = ~a & c; // out[24] = a^c
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
