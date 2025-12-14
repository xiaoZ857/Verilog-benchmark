
module TopModule (
  input wire a,
  input wire b,
  input wire c,
  output reg w,
  output reg x,
  output reg y,
  output reg z
);

assign w = a;
assign x = b;
assign y = b;
assign z = c;

always @(posedge clk) begin
  // Since the signals are positive edge triggered and no internal logic is defined, no clock is required.
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
