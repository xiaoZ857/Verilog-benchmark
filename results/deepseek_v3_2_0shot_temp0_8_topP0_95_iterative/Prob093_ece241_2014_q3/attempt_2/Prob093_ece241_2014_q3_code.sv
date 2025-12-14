
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
  // mux_in[0] = c + d (OR gate)
  // Using mux: f = sel ? b : a with sel=c, a=d, b=1 gives: c ? 1 : d = c + d
  wire mux0_sel = c;
  assign mux_in[0] = mux0_sel ? 1'b1 : d;
  
  // mux_in[1] = 0
  assign mux_in[1] = 1'b0;
  
  // mux_in[2] = c·d (AND gate)
  // Using mux: f = sel ? b : a with sel=c, a=0, b=d gives: c ? d : 0 = c·d
  wire mux2_sel = c;
  assign mux_in[2] = mux2_sel ? d : 1'b0;
  
  // mux_in[3] = d' + c = NOT d OR c
  // Using mux: f = sel ? b : a with sel=d, a=1, b=c gives: d ? c : 1 = d' + c
  wire mux3_sel = d;
  assign mux_in[3] = mux3_sel ? c : 1'b1;
endmodule
