
module TopModule (
  input [7:0] in,
  output [31:0] out
);
 ```verilog
always_comb begin
    out = {8'b0, in[7], repeat(24, in[7]) , in[6:0]};
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
