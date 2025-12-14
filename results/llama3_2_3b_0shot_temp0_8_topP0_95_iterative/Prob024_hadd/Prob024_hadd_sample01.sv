
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
always @(*) begin
    assign sum = a ^ b;  // XOR operation for half adder
    assign cout = ((a & b) != 0);  // AND operation with non-zero value to get carry-out
end

// VERILOG-EVAL: endmodule not found
