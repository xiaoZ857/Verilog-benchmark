
module TopModule (
  input [3:0] in,
  output reg out_and,
  output reg out_or,
  output reg out_xor
);

// Use built-in gates from Verilog library 'ieee'
include "ieee.v"

AND4 andGate (.Y(out_and), .A(in[3]), .B(in[2]), .C(in[1]), .D(in[0]) );
OR4 orGate  (.Y(out_or ), .A(in[3]), .B(in[2]), .C(in[1]), .D(in[0]) );
XOR4 xorGate(.Y(out_xor), .A(in[3]), .B(in[2]), .C(in[1]), .D(in[0]) );

always @(posedge clk) begin
  // No clock for internal signals as they are combinational
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
