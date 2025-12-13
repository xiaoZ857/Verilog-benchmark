
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
wire mux0_in0, mux0_in1;
wire mux2_in0, mux2_in1;
wire mux3_in0, mux3_in1;

assign mux0_in0 = d;
assign mux0_in1 = 1'b1;
assign mux_in[0] = c ? mux0_in1 : mux0_in0;

assign mux_in[1] = 1'b0;

assign mux2_in0 = ~d;
assign mux2_in1 = 1'b1;
assign mux_in[2] = c ? mux2_in1 : mux2_in0;

assign mux3_in0 = 1'b0;
assign mux3_in1 = d;
assign mux_in[3] = c ? mux3_in1 : mux3_in0;
