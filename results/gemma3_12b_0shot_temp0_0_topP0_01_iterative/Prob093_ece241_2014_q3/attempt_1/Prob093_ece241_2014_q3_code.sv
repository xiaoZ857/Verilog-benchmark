
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

  wire a = c;
  wire b = d;

  // Implement the K-map using 2-to-1 multiplexers and a 4-to-1 multiplexer.
  // The K-map is:
  //
  //      ab
  //  cd  00  01  11  10
  //  00 | 0 | 0 | 0 | 1 |
  //  01 | 1 | 0 | 0 | 0 |
  //  11 | 1 | 0 | 1 | 1 |
  //  10 | 1 | 0 | 0 | 1 |

  // mux_in[0] = 0 when c=0, 1 when c=1
  assign mux_in[0] = ~c;

  // mux_in[1] = 1 when c=0, 0 when c=1
  assign mux_in[1] = c;

  // mux_in[2] = 1 when c=1, 0 when c=0
  assign mux_in[2] = c;

  // mux_in[3] = 1 when c=1, 0 when c=0
  assign mux_in[3] = c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
