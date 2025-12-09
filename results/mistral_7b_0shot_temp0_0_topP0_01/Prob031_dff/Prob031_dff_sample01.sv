
module TopModule (
  input wire clk,
  input wire d,
  output reg q
);

always @(posedge clk)
begin
  q <= d;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
