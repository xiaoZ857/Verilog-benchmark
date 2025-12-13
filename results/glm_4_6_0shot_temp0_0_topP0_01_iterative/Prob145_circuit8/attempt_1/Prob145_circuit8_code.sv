
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

  // p is triggered on rising edge and follows a when clock is high
  always @(posedge clock) begin
    p <= a;
  end

  // q is triggered on falling edge and captures p's value
  always @(negedge clock) begin
    q <= p;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
