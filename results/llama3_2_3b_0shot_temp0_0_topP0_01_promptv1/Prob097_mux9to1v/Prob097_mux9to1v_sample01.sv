
module TopModule (
  input [15:0] a,
  input [15:0] b,
  input [15:0] c,
  input [15:0] d,
  input [15:0] e,
  input [15:0] f,
  input [15:0] g,
  input [15:0] h,
  input [15:0] i,
  input [3:0] sel,
  output logic [15:0] out
);
assign out = {sel[2:0], sel[1:0]*{1'b1, 1'b0}} | {sel[4:3]*{1'b1, 1'b0}, sel[5:4]*{1'b1, 1'b0}};
assign out[7:6] = sel[8:7]*{1'b1, 1'b0};
assign out[5:4] = sel[9:8]*{1'b1, 1'b0};
assign out[3:2] = sel[10:9]*{1'b1, 1'b0};
assign out[1:0] = sel[11:10]*{1'b1, 1'b0};

// VERILOG-EVAL: endmodule not found
