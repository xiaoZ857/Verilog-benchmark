
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output logic overflow
);
  
signed [7:0] sum_a_b;

always_comb begin
  // Calculate the sum of a and b using binary addition
  sum_a_b = a + b;
end

assign s[1:0] = |sum_a_b; // get two least significant bits of sum (2's complement)
if(|sum_a_b>127) overflow <= 1; else overflow <= 0;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
