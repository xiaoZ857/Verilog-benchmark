
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  // Declare internal registers for each D flip-flop
  reg [7:0] ff;

  always @(posedge clk or posedge reset) begin
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

endmodule

// VERILOG-EVAL: errant inclusion of module definition
