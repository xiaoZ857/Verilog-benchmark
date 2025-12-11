
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
assign out_assign = a ^ b;

always @(*) begin
    out_always_comb = a ^ b;
end

always @(posedge clk) begin
    if (reset)
        out_always_ff <= 1'b0;
    else
        out_always_ff <= a ^ b;
end

// VERILOG-EVAL: endmodule not found
