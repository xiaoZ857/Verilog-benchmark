
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

// Assign statement for XOR
assign out_assign = a ^ b;

// Combinational always block for XOR
always @(*) begin
  out_always_comb = a ^ b;
end

// Clocked always block with flip-flop for XOR
always @(posedge clk) begin
  out_always_ff <= a ^ b;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
