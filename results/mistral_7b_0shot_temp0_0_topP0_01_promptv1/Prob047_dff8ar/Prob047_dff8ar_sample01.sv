
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
 ```verilog
always @(posedge clk or negedge areset) begin
    if (!areset)
        q <= 8'b0;
    else
        q <= d;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
