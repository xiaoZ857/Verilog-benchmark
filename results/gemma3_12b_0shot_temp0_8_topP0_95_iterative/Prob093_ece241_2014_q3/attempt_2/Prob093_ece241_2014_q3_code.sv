
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
  wire [3:0] mux_in_temp;

  wire mux_in_0 = c & ~d;  // corresponds to 00
  wire mux_in_1 = ~c & d;  // corresponds to 01
  wire mux_in_2 = ~c & ~d; // corresponds to 11
  wire mux_in_3 = c & d;    // corresponds to 10

  assign mux_in_temp[0] = mux_in_0;
  assign mux_in_temp[1] = mux_in_1;
  assign mux_in_temp[2] = mux_in_2;
  assign mux_in_temp[3] = mux_in_3;

  assign mux_in = mux_in_temp;
endmodule
