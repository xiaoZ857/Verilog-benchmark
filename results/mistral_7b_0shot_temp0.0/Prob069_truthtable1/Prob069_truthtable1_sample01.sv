
module TopModule (
  input wire x3,
  input wire x2,
  input wire x1,
  output reg f
);

always @(posedge clk) begin
  assign f = (x3 & ~x2 & x1) | (~x3 & x2 & ~x1) | (x3 & x2 & x1);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
