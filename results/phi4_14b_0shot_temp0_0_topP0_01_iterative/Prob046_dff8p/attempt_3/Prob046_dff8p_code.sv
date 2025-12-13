
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(negedge clk) begin
  if (reset) begin
    // Synchronously set all flip-flops to 0x34 on reset
    ff <= 8'b00110100;
  end else begin
    // On negative edge of clock, load input d into the registers
    ff <= d;
  end
  // Directly assign internal register values to output
  q <= ff;
end

endmodule
