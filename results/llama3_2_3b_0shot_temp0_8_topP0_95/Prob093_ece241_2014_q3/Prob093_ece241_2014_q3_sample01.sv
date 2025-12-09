
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

  wire sel;
  assign sel = ((c == 0) && (d == 0)) ? 1 : 0;

  wire a, b, ab;
  assign a = sel; // from K-map description
  assign b = !sel; // from K-map description

  wire [2:0] temp_in[3:0];
  assign temp_in[3] = (c == 0) ? '1 : '0;
  assign temp_in[2] = (c == 0 && d == 1) ? '1 : '0;
  assign temp_in[1] = (c == 1) ? '1 : '0;
  assign temp_in[0] = !sel; // from K-map description

  wire [3:0] mux_in_out[3:0];
  assign mux_in_out[0] = ab;
  assign mux_in_out[1] = temp_in[2] & b;
  assign mux_in_out[2] = (temp_in[1] ^ temp_in[0]) & a;
  assign mux_in_out[3] = temp_in[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
