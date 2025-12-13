
// Set time scale for simulation (1 ns = 1 nanosecond)
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;
    else if (E) begin
        Q <= w;
    end else begin
        Q <= Q; // Hold current value
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
