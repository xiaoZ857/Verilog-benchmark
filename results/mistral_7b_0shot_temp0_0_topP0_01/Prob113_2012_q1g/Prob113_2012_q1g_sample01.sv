
module TopModule (
  input [4:1] x,
  output logic f
);

always @(posedge clk) begin
  assign f = x[1] & ~x[2] | x[3] & x[4];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
