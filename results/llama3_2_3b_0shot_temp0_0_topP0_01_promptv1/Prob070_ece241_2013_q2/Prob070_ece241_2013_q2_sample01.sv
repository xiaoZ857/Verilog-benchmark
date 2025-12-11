
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
assign out_sop = (a & b & c & d) | (a & b & ~c & d) | (~a & b & c & d) |
                 (a & ~b & c & d) | (~a & b & ~c & d) | (~a & ~b & c & d) |
                 (a & b & c & ~d) | (a & b & ~c & ~d) | (~a & b & c & ~d) |
                 (a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & ~b & c & ~d) |
                 (a & b & ~d & d) | (a & ~b & ~d & d) | (~a & b & ~d & d) |
                 (a & b & ~d & ~d) | (a & ~b & ~d & ~d) | (~a & b & ~d & ~d);

assign out_pos = ~(~a & b & c & d) & ~(a & ~b & c & d) & ~(a & b & ~c & d) |
                 ~(a & ~b & ~c & d) & ~(a & b & c & ~d) & ~(a & ~b & c & ~d) &
                 ~(a & b & ~c & ~d) | (a & ~b & c & ~d) | (~a & b & c & ~d) |
                 (~a & b & c & d) | (a & ~b & c & d) | (~a & b & ~c & d) | 
                 (a & b & ~c & d) | (a & ~b & ~c & d) | (~a & b & ~d & d) |
                 ~(a & b & ~d & d) | ~(a & ~b & ~d & d) | ~(a & b & ~d & ~d) |
                 ~(a & ~b & ~d & ~d);

// VERILOG-EVAL: endmodule not found
