
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);

wire [1:0] sel;
assign sel = {d, c};

wire [3:2] in0, in1, in2, in3;

assign in0 = (a & ~b) | (~a);
assign in1 = (a & b) | (~a & ~b);
assign in2 = (c & ~d) | (~c);
assign in3 = (c & b) | (~c & ~b);

wire [3:0] out;

assign out = {sel[1], sel[0], in0, in2};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
