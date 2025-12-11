
module TopModule (
  input x,
  input y,
  output z
);
wire a1_z, a2_z, b1_z, b2_z;
wire or_out, and_out;

A a1 (.x(x), .y(y), .z(a1_z));
A a2 (.x(x), .y(y), .z(a2_z));
B b1 (.x(x), .y(y), .z(b1_z));
B b2 (.x(x), .y(y), .z(b2_z));

assign or_out  = a1_z |

// VERILOG-EVAL: endmodule not found
