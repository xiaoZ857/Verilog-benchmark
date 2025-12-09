
module TopModule (
  input [4:1] x,
  output logic f
);

always @(posedge clk) begin
  assign f = ~x[3] & x[2] | x[3] & ~x[4] | x[2] & x[4];
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
