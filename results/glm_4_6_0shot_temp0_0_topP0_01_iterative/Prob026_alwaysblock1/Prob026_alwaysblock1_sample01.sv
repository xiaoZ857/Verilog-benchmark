
module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

// Implement the AND gate using assign statement
assign out_assign = a & b;

// Implement the AND gate using combinational always block
always @(*) begin
  out_alwaysblock = a & b;
end

endmodule
