
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
// Verilog implementation of 4-to-1 multiplexer (MUX4) using 2 MUX2 and the selectors a and b
module MUX4 #(parameter A = 0, B = 1)(
    input a, b,
    input [3:0] d_in,
    output out
);

   assign out = d_in[a]*b + d_in[A+b]; // XOR gates not explicitly shown for simplicity
endmodule

// Verilog implementation of 2-to-1 multiplexer (MUX2)
module MUX2 #(parameter S = 0)(
    input sel,
    input in1, in2,
    output out
);

assign out = sel ? in1 : in2;

endmodule

// TopModule implementation for the given Karnaugh map
TopModule:
  MUX4 MUX_cd_00 (c, d, mux_in[0]); // ab=00 case
  MUX4 MUX_cd_01 (c, d, mux_in[1]); // ab=01 case
  MUX4 MUX_cd_11 (c, ~d, mux_in[2]); // ab=11 case (using the complement of 'd')
  MUX4 MUX_cd_10 (c, ~d, mux_in[3]); // ab=10 case (using the complement of 'd')
