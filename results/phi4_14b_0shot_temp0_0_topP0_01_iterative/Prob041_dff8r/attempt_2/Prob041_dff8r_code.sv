
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
  // Declare internal registers for each D flip-flop
  reg [7:0] ff;

  always @(posedge clk) begin
    if (reset) begin
      // Synchronous reset: set all outputs to zero
      ff <= 8'b00000000;
    end else begin
      // On positive edge of clock, load input d into flip-flops
      ff <= d;
    end
  end

  // Assign the internal register values to output
  always @(*) begin
    q = ff;
  end

// VERILOG-EVAL: endmodule not found
