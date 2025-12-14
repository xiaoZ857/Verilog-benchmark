
module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

assign out[24] = ~(a ^ a);  // ~a ^ a is always true (1)
assign out[23] = ~(a ^ b);
assign out[22] = ~(a ^ c);
assign out[21] = ~(a ^ d);
assign out[20] = ~(a ^ e);

assign out[19] = ~(b ^ a);  // ~b ^ a
assign out[18] = ~(b ^ b);  // ~b ^ b is always true (1)
assign out[17] = ~(b ^ c);
assign out[16] = ~(b ^ d);
assign out[15] = ~(b ^ e);

assign out[14] = ~(c ^ a);  // ~c ^ a
assign out[13] = ~(c ^ b);  // ~c ^ b
assign out[12] = ~(c ^ c);  // ~c ^ c is always true (1)
assign out[11] = ~(c ^ d);
assign out[10] = ~(c ^ e);

assign out[9]  = ~(d ^ a);  // ~d ^ a
assign out[8]  = ~(d ^ b);  // ~d ^ b
assign out[7]  = ~(d ^ c);  // ~d ^ c
assign out[6]  = ~(d ^ d);  // ~d ^ d is always true (1)
assign out[5]  = ~(d ^ e);

assign out[4]  = ~(e ^ a);  // ~e ^ a
assign out[3]  = ~(e ^ b);  // ~e ^ b
assign out[2]  = ~(e ^ c);  // ~e ^ c
assign out[1]  = ~(e ^ d);  // ~e ^ d
assign out[0]  = ~(e ^ e);  // ~e ^ e is always true (1)

endmodule

// VERILOG-EVAL: errant inclusion of module definition
