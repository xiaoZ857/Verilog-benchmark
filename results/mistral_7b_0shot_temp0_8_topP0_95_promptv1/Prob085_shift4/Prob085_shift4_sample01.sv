
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
 ```verilog
always @(posedge clk or negedge areset)
begin
    if (!areset)
        q <= 4'b0;
    else if (load && ena)
        q <= data;
    else if (ena)
        q <= {q[1:0], 4'b0};
end

always @* begin
    if (!ena)
        q[3] <= 1'b0;
    else
        q[0] <= q[3];
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
