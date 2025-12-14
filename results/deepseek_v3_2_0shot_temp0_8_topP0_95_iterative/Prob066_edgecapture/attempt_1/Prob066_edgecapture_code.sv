
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end else begin
        out <= out | ({in[30:0], 1'b0} & ~in);
    end
end

// VERILOG-EVAL: endmodule not found
