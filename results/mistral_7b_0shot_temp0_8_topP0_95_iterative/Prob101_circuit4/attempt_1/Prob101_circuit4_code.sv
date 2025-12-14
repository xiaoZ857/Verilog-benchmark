
module TopModule (
  input wire a,
  input wire b,
  input wire c,
  input wire d,
  output reg q
);

always @(posedge clk) begin
  if ((a || b || c || d) && !q) begin
    q <= 1'b1;
  end
end

initial begin
  clk = 0;
  #5 clk = 1;
end

initial repeat (30) begin
  #5 { a = a ^ 1; b = b ^ 1; c = c ^ 1; d = d ^ 1; }
  #5 $finish;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
