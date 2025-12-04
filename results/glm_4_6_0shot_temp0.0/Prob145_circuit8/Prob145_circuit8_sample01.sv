
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

  // p follows a on rising edge of clock
  always @(posedge clock) begin
    p <= a;
  end

  // q follows p on falling edge of clock
  always @(negedge clock) begin
    q <= p;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
