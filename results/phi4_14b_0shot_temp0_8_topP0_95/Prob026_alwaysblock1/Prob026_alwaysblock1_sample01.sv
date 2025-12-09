
module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Implementing AND using assign statement
  assign out_assign = a & b;

  // Implementing AND using combinational always block
  always @(*) begin
    out_alwaysblock = a & b;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
