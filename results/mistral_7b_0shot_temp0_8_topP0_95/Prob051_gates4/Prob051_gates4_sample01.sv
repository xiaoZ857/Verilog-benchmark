
module TopModule (
  input [3:0] in,
  output reg out_and,
  output reg out_or,
  output reg out_xor
);

// Declare 4-input AND gate
and4 #(.A(in[0]), .B(in[1]), .C(in[2]), .D(in[3]), .Y(out_and)) and_gate (U1);

// Declare 4-input OR gate
or4 #(.A(in[0]), .B(in[1]), .C(in[2]), .D(in[3]), .Y(out_or)) or_gate (U2);

// Declare 4-input XOR gate
xor4 #(.A(in[0]), .B(in[1]), .C(in[2]), .D(in[3]), .Y(out_xor)) xor_gate (U3);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
