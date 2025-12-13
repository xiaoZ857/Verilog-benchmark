
module TopModule (
  input wire in,
  output reg out
);

always @(posedge clk) begin
  out <= in;
end

// If you want to make the assignment combinatorial (zero delay), uncomment the following line:
// assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
