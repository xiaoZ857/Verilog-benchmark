
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= 8'b0;
    end else begin
        out <= (~sel & a) | (sel & b);
    end
end

// VERILOG-EVAL: endmodule not found
