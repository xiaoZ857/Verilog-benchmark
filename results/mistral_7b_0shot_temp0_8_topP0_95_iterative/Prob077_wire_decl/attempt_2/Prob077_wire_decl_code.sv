
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

// Intermediate wire to connect the AND and OR gates together
wire intermed_wire = and1 | and2;

// Second layer OR gate and inverter for out_n
or (out, intermed_wire);
assign out_n = ~out;

// VERILOG-EVAL: endmodule not found
