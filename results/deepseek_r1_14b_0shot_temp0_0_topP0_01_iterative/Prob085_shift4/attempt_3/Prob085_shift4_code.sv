
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        q <= 0;
    end else begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            // Right shift with zero fill
            q <= (q >> 1);
        end
    end
end

// VERILOG-EVAL: abnormal backticks count
