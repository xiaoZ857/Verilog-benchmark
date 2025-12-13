
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

  // p follows a when clock is high (level-sensitive)
  always @(*) begin
    if (clock) 
      p = a;
    else 
      p = p;  // hold value when clock is low
  end

  // q captures p's value on falling edge of clock
  always @(negedge clock) begin
    q <= p;
  end

endmodule
