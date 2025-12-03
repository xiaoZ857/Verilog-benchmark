

module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

// Implement three different XOR gates
assign out_assign = a ^ b;

always @(*) begin
    out_always_comb = a ^ b;
end

always @(posedge clk) begin
    if (a ^ b)
        out_always_ff = 1;
    else 
        out_always_ff = 0;
end

// VERILOG-EVAL: endmodule not found
