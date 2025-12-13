
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    for (int i = 0; i < 512; i++) begin
      // Get the left, center, and right neighbors with boundary conditions
      bit left = (i > 0) ? q[i-1] : 0;
      bit center = q[i];
      bit right = (i < 511) ? q[i+1] : 0;

      case ({left, center, right})
        3'b111: q[i] <= 0; // 7 -> 0
        3'b110: q[i] <= 1; // 6 -> 1
        3'b101: q[i] <= 1; // 5 -> 1
        3'b100: q[i] <= 0; // 4 -> 0
        3'b011: q[i] <= 1; // 3 -> 1
        3'b010: q[i] <= 1; // 2 -> 1
        3'b001: q[i] <= 1; // 1 -> 1
        default: q[i] <= 0; // 0 -> 0 (and other cases)
      endcase
    end
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
