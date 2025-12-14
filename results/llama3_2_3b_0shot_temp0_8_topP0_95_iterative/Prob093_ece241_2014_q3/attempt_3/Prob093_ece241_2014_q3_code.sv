
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
assign mux_in[0] = ~(a & ~b);
assign mux_in[2] = c;
assign mux_in[3] = d;

assign select = {a, b};
assign mux_in[1] = (select == 4'd01) ? mux_in[3] : ~mux_in[3];
assign mux_in[1] = (select != 4'd01) ? mux_in[2] : ~(mux_in[2]);

// VERILOG-EVAL: endmodule not found
