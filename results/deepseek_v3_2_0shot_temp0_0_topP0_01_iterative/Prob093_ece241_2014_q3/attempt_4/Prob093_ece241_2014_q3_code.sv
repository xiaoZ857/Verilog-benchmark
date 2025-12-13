
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
wire mux0_in0, mux0_in1;
wire mux2_in0, mux2_in1;
wire mux3_in0, mux3_in1;

// mux_in[0] = ~c + d = d ? 1 : ~c
assign mux0_in0 = ~c;  // when d=0
assign mux0_in1 = 1'b1; // when d=1
assign mux_in[0] = d ? mux0_in1 : mux0_in0;

// mux_in[1] = 0
assign mux_in[1] = 1'b0;

// mux_in[2] = c & d
assign mux2_in0 = 1'b0;  // when d=0
assign mux2_in1 = c;     // when d=1
assign mux_in[2] = d ? mux2_in1 : mux2_in0;

// mux_in[3] = ~d | c = d ? c : 1
assign mux3_in0 = 1'b1;  // when d=0
assign mux3_in1 = c;     // when d=1
assign mux_in[3] = d ? mux3_in1 : mux3_in0;

endmodule
