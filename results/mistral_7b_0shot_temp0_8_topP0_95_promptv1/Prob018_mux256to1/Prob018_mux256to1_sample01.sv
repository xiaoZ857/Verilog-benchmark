
module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output  out
);
always @(posedge clk) begin
    assign out = in[sel];
end

// VERILOG-EVAL: endmodule not found
