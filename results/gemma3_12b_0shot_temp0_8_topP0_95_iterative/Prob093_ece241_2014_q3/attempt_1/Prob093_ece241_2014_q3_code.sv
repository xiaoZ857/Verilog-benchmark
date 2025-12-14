
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

  wire a = c;
  wire b = d;

  // Implement the K-map using 2-to-1 multiplexers and a 4-to-1 multiplexer.
  // First, build a 4-to-1 multiplexer with inputs connected to the K-map values.

  wire mux_in_0_1 = c & ~d;  // corresponds to 00
  wire mux_in_0_2 = ~c & d;  // corresponds to 01
  wire mux_in_0_3 = ~c & ~d; // corresponds to 11
  wire mux_in_1_1 = c & d;    // corresponds to 10

  assign mux_in[0] = mux_in_0_1;
  assign mux_in[1] = mux_in_0_2;
  assign mux_in[2] = mux_in_0_3;
  assign mux_in[3] = mux_in_1_1;


endmodule

// VERILOG-EVAL: errant inclusion of module definition
