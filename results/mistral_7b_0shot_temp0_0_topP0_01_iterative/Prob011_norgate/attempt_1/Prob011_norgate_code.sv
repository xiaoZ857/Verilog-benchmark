
module TopModule (
  input a,
  input b,
  output reg out
);

always @(posedge clk) begin
  out <= ~(a | b);
end

// If no clock is specified, the default is posedge clock/clk
// So you can omit the always @(posedge clk) block if you don't have a global clock signal

// Alternatively, if you want to use an event-controlled assignment (level-sensitive),
// you can use the following code:

// `event none;
// `event e1 = a or b;
// input a, b;
// output reg out;
//
// assign out = ~(a | b);
// eventually_t e2: e1 => out <= ~(a | b);

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
