
module TopModule (
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);
assign temp_and1 = p1a & p1b & p1c;
assign temp_and2 = p1d & p1e & p1f;
assign p1y = temp_and1 | temp_and2;

assign temp_and3 = p2a & p2b;
assign temp_and4 = p2c & p2d;
assign p2y = temp_and3 | temp_and4;
endmodule
