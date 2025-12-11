
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
 ```verilog
always @* begin
    out_and = in[3] & in[2] & in[1] & in[0];
end

always @* begin
    out_or = in[3] | in[2] | in[1] | in[0];
end

assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
