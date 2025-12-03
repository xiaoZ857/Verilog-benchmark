
module TopModule (
  input wire x,
  input wire y,
  output reg z
);

always @(posedge clk) begin
  assign z = (x ^ y) & x;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
