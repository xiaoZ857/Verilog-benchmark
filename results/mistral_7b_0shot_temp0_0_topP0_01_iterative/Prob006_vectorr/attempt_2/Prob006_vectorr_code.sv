
module TopModule (
  input [7:0] in,
  output [7:0] out
);
always @(posedge clk) begin
  out <= {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

endmodule
