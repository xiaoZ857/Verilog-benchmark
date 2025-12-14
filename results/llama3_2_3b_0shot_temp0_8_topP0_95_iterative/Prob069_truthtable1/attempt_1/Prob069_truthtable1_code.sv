
module TopModule (
  input x3, // input signal
  input x2, // input signal
  input x1, // input signal
  output f   // output signal
);

    assign f = (~x3 & ~x2) | (x1 & ~x2) | (~x3 & x2 & x1);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
