
module TopModule (
  input wire a,
  input wire b,
  output reg out
);

always @(posedge clk) begin
  if(a && b)
    out <= 1;
  else
    out <= 0;
end

// You can remove the following line if you don't want to specify an initial value for out.
initial begin
  out <= 0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
