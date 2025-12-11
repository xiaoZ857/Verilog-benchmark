
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
assign out = (sel[2] ? a : (sel[1] ? b : (sel[0] ? c : (sel[4] ? d : (sel[5] ? e : (sel[6] ? f : (sel[7] ? g : (sel[8] ? h : (sel[9] ? i : '1)))))))))

// VERILOG-EVAL: endmodule not found
