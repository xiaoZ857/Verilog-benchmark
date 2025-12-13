
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = (~x[3] & ~x[4] & ~x[2] & ~x[1]) |  // d set to 1 for grouping
              (~x[3] & x[4] & x[2] & x[1]) |   // minterm 1
              (x[3] & ~x[4] & ~x[2] & ~x[1]) | // minterm 1
              (x[3] & ~x[4] & ~x[2] & x[1]) |  // minterm 1
              (x[3] & x[4] & ~x[2] & ~x[1]) |  // minterm 1
              (x[3] & x[4] & ~x[2] & x[1]);    // minterm 1

endmodule
