
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

// First layer AND gates
wire and1 = a & b;
wire and2 = c & d;

// Second layer OR gate and inverter for out_n
wire or_out;
or (output or_out, and1, and2);
assign out = or_out;
not (out_n, or_out);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
