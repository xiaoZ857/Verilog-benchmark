
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
  wire [3:0] inputs;
  wire [2:0] count;
  
  assign inputs = {a, b, c, d};
  assign count = inputs[0] + inputs[1] + inputs[2] + inputs[3];
  assign q = (count >= 2'd2);
endmodule
