
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
always @(posedge clk) begin
    for (int i = 0; i <= 99; i++) begin
        out[i] <= in[99-i];
    end
end

reg [99:0] reset_out = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= reset_out;
    end
end

input reset;
assign in = your_input_vector;

// Timescale directive should be placed at the top level of your design, not inside a module.
`timescale 1ns / 1ps

endmodule
