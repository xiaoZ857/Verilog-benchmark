
// Compilation fixed by moving $timescale outside module
$timescale 1ns $end

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

wire and_out_1, and_out_2, or_out;

and gate_and1(a, b, and_out_1);
and gate_and2(c, d, and_out_2);
or gate_or(and_out_1, and_out_2, or_out);

assign out = or_out;
assign out_n = ~out;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
