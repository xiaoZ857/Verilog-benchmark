
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
assign out = sel >= 4'b1000 ? {8'd1, {7:0}8'd1} : {sel[2:0], sel[1:0], {7:0}8'd1};

// VERILOG-EVAL: endmodule not found
