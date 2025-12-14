
module TopModule (
  input x3,
  input x2,
  input x1,
  output reg f
);

always @(*) begin
    // Implementing the derived Boolean expression for f
    f = (x2 & ~x3) | (x1 & x3);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
