
module TopModule (
  input a,
  input b,
  input c,
  input d,
  input e,
  output reg [24:0] out
);

always @(posedge clk) begin
  out[0] = ~e & e; // out[0] = e^e
  out[1] = ~e & d; // out[1] = e^d
  out[2] = ~e & c; // out[2] = e^c
  out[3] = ~e & b; // out[3] = e^b
  out[4] = ~e & a; // out[4] = e^a

  out[5] = ~d & e; // out[5] = d^e
  out[6] = ~d & c; // out[6] = d^c
  out[7] = ~d & b; // out[7] = d^b
  out[8] = ~d & a; // out[8] = d^a

  out[9] = ~c & e; // out[9] = c^e
  out[10] = ~c & d; // out[10] = c^d
  out[11] = ~c & b; // out[11] = c^b
  out[12] = ~c & a; // out[12] = c^a

  out[13] = ~b & e; // out[13] = b^e
  out[14] = ~b & d; // out[14] = b^d
  out[15] = ~b & c; // out[15] = b^c
  out[16] = ~b & a; // out[16] = b^a

  out[17] = ~a & e; // out[17] = a^e
  out[18] = ~a & d; // out[18] = a^d
  out[19] = ~a & c; // out[19] = a^c
  out[20] = ~a & b; // out[20] = a^b

  out[21] = a & e; // out[21] = a \* e
  out[22] = a & d; // out[22] = a \* d
  out[23] = a & c; // out[23] = a \* c
  out[24] = a & b; // out[24] = a \* b
endmodule

// VERILOG-EVAL: errant inclusion of module definition
