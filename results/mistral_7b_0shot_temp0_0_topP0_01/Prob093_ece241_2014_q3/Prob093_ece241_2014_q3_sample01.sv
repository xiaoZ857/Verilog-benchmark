
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

// Define two-to-one multiplexers
mux2 (.a(c), .b(d), .sel(0), .output(mux_in[0]));
mux2 (.a(c), .b(~d), .sel({1'b0, 1'b1}), .output(mux_in[1]));
mux2 (.a(~c), .b(d), .sel({1'b1, 1'b0}), .output(mux_in[2]));
mux2 (.a(~c), .b(~d), .sel({1'b1, 1'b1}), .output(mux_in[3]));

// Define a four-to-one multiplexer with the selector inputs 'a' and 'b'
// as specified in the problem statement.
mux4 (.a(a), .b(b), .sel({mux_in[0], mux_in[1], mux_in[2], mux_in[3]}), .output(y));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
