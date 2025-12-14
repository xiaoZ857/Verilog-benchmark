
module TopModule (
  output one
);
always @(*) begin
  one <= 1;
end

// Output signal: always drives to 1 (logic high)
assign one = 1;

// VERILOG-EVAL: endmodule not found
