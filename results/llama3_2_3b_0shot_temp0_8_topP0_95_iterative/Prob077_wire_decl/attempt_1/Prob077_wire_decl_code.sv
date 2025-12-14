
// Define the intermediate wires
wire wire1, wire2;

// Create AND gates for the first layer
and gate1(a, b, wire1);
and gate2(c, d, wire2);

// Create OR gate for the second layer
or gate2(wire1, wire2, out);

// Invert the output of the OR gate
not gate3(out, out_n);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
