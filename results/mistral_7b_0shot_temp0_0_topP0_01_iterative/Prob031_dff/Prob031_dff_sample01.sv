
module TopModule (
  input wire clk,
  input wire d,
  output reg q
);

always @(posedge clk)
begin
  if (d)
    q <= 1'b1;
  else
    q <= 1'b0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
