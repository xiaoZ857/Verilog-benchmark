
// TopModule.v
//
//  Sign‑extend an 8‑bit value (in) to 32 bits (out).
//  The 8‑bit input is assumed to be a signed two‑s complement number
//  (bit[7] is the sign bit).  The output is simply the sign bit replicated
//  24 times followed by the original 8 bits.
//
//  This is a combinational circuit – the output follows the input
//  immediately on the next clock edge (or right after the input changes
//  if the design is purely combinational).

module TopModule (
    input  wire [7:0]  in,   // 8‑bit signed input
    output wire [31:0] out   // 32‑bit sign‑extended output
);

//  Use the replication operator to repeat the sign bit 24 times
//  and concatenate it with the original 8‑bit vector.
assign out = {24{in[7]}, in};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
