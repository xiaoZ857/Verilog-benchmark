
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
 ```verilog
always @(posedge clk) begin
    if (in === 8'b0)
        pos <= 3'bz;
    else
        pos = {in[0], in[1], in[2]} | {in[3], in[4], in[5]} << 1 | {in[6], in[7]} << 2;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
