
// Set the simulation time units (correctly placed outside the module)
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

always @ (posedge clk) begin
  for (int i = 0; i < 8; i++) begin
    // Detect positive edge on each bit of 'in'
    if (~in[i] && in[i]) begin
      pedge[i] <= 1;
    end else begin
      pedge[i] <= 0;
    end
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
