
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
assign q = {{reset, d[7], d[6], d[5], d[4], d[3], d[2], d[1]}};

always @(posedge clk) begin
    if (reset)
        q <= 34'd34;
    else
        q <= d;
end

// VERILOG-EVAL: endmodule not found
