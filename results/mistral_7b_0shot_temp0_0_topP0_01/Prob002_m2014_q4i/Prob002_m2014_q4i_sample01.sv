
module TopModule (
  output out
);

always @(posedge clk)
begin
  out <= 0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
