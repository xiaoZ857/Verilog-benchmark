
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a == 1'b1) begin
        q <= q + 1;
    end else begin
        q <= 3'b000; // Reset to zero when 'a' is low
    end
end

// VERILOG-EVAL: abnormal backticks count
