
module TopModule (
  input [15:0] in,
  output reg [7:0] out_hi,
  output reg [7:0] out_lo
);

always @(posedge clk) begin
  out_hi <= in [15:8];
  out_lo <= in [7:0];
end

// If needed, you can add clock enable for the outputs if they should be gated with the clock signal
// e.g.,:
// always @(posedge clk) begin
//   if (clk_en) begin
//     out_hi <= in [15:8];
//     out_lo <= in [7:0];
//   end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
