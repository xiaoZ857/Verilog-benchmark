
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
  wire [3:0] mux_in_temp;

  assign mux_in_temp[0] = c & ~d;  // corresponds to 00
  assign mux_in_temp[1] = ~c & d;  // corresponds to 01
  assign mux_in_temp[2] = ~c & ~d; // corresponds to 11
  assign mux_in_temp[3] = c & d;    // corresponds to 10

  assign mux_in = mux_in_temp;
endmodule
