
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q = $signed({9'b000, 1'b1});

always @(posedge clk) begin
    if (reset)
        q <= 4'd1;
    else if ($signed(q) < 10'd10)
        q <= $signed(q) + 1'b1;
end

// VERILOG-EVAL: endmodule not found
